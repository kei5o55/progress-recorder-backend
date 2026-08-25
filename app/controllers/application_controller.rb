# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # 新規登録時に name を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :bio, :bgm_url, :icon])
    # アカウント更新時に name 等を許可
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :bio, :bgm_url, :icon])
  end
end