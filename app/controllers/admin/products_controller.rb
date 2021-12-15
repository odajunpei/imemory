class Admin::ProductsController < ApplicationController

  before_action :authenticate_admin!

  def new
    @product = Product.new
  end

  def index
    if params[:word].present?
      @word = params[:word]
      @products = search(@word , Product).page(params[:page]).per(14)
    else
      @products = Product.page(params[:page]).per(14).order("#{sort_column} #{sort_direction}")
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product), notice: "商品を登録しました。"
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_product_path(params[:id]), notice:"商品情報を更新しました。"
    else
      render :edit
    end
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
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end
  
  
private

    def product_params
      params.require(:product).permit(:image, :name, :introduction, :price, :is_active, :genre_id)
    end

end
