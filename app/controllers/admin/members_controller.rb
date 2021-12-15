class Admin::MembersController < ApplicationController
   before_action :authenticate_admin!

  def index
    if params[:word].present?
      @word = params[:word]
      @members= search(@word,Member).page(params[:page]).per(14)
    else
      @members = Member.page(params[:page]).per(14).order("#{sort_column} #{sort_direction}")
    end
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member= Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = "登録情報を変更しました"
      redirect_to admin_member_path(@member)
    else
      render "edit"
    end
  end
  
  def search(word, item)
    words = word.split(/[[:blank:]]+/).select(&:present?)
    not_word, or_and_word = words.partition { |word| word.start_with?("-") }
    or_word, and_word = or_and_word.partition { |word| word.start_with?("|") }
    
    items = item.all
    and_word.each do |word|
      items = items.where("last_name LIKE ? OR first_name LIKE ? OR email LIKE ?","%#{word}%","%#{word}%","#{word}")# if word.present?
    end
    or_word.each do |word|
      items = items.or(item.where("last_name LIKE ? OR first_name LIKE ?","%#{word.delete_prefix('|')}%","%#{word.delete_prefix('|')}%","%#{word.delete_prefix('|')}%"))
    end
    not_word.each do |word|
      items.where!("last_name LIKE ? OR first_name LIKE ?", "%#{word.delete_prefix('-')}%", "%#{word.delete_prefix('-')}%", "%#{word.delete_prefix('-')}%")
    end
    return items
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    Member.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end
  
  private

  def member_params
  	params.require(:member).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number,:is_deleted)
  end

end
