class Members::MembersController < ApplicationController
   before_action :authenticate_member!

  def show
    @member = Member.find(current_member.id)
  end

  def edit
    @member = Member.find(current_member.id)
  end

  def update
    @member= Member.find(current_member.id)
    if @member.update(member_params)
      flash[:notice] = "登録情報を保存しました"
      redirect_to members_path(current_member.id)
    else
      render :edit
    end
  end

  def leave
    @member=Member.find(current_member.id)
  end

  def withdraw
    @member = Member.find(current_member.id)
    @member.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def member_params
  	params.require(:member).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number,:is_deleted)
  end


end
