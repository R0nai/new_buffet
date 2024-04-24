class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :buffet_not_registered_yet

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def buffet_not_registered_yet
    exception_routes = [destroy_owner_session_path, new_buffet_path, buffets_path]
    if current_owner && current_owner.buffet.nil?
      unless exception_routes.any? {|route| route == url_for(only_path: true)}
        redirect_to new_buffet_path
      end
    end
  end
end
