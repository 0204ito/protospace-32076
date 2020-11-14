class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only:[:edit, :create,:update,:destry]
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
  end
end
