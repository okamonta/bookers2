class ApplicationController < ActionController::Base
  # home/about へはアクセスできるのか？
  before_action :authenticate_user!,except: [:top, :about]

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # ログイン後、book#showページへ。
  def after_sign_in_path_for(resource)
    book_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
end
