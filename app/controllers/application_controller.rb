class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  $tax_rate = 1.08 #税率のグローバル変数
  $potage = 800 #送料のグローバル変数

  #ログアウト時のパス
  def after_sign_out_path_for(resource)
      root_path
  end

  #新規登録保存
  protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up,
        keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number])
    end
end
