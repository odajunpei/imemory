class Members::ProductsController < ApplicationController

  def index
    if params[:word].present?
      @product_name = "商品：" + params[:word]
      @word = params[:word]
      @products = search(@word , Product).page(params[:page]).per(6)
      if @products.blank?
        @products = "no_search"
      end
    elsif params[:genre].present?
      @gunre_name = "ジャンル：" + params[:genre]
      @gunre = Genre.search(params[:genre])
      @products =  @gunre[0].products.page(params[:page]).per(6)
      if @products.blank?
        @products = "no_search"
      end
    else
      @products = Product.page(params[:page]).order(id: "DESC").per(6)
    end
    @genres = Genre.all
  end

  def show
    @product = Product.find(params[:id])
    @cart_product = CartProduct.new
    @genres = Genre.all
  end


  def search(word, item)
    words = word.split(/[[:blank:]]+/).select(&:present?)
    not_word, or_and_word = words.partition { |word| word.start_with?("-") }
    or_word, and_word = or_and_word.partition { |word| word.start_with?("|") }

    items = item.all
    and_word.each do |word|
      items = items.where("name LIKE ?","%#{word}%")# if word.present?
    end
    or_word.each do |word|
      items = items.or(item.where("name LIKE ?","%#{word.delete_prefix('|')}%"))
    end
    not_word.each do |word|
      items.where!("name NOT LIKE ?", "%#{word.delete_prefix('-')}%")
    end
    return items
  end


   private
     def product_params
       params.require(:product).permit(:image, :name, :introduction, :price, :is_active, :genre_id)
     end


end