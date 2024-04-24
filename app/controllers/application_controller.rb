class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :buffet_not_registered_yet

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def buffet_not_registered_yet
    if current_owner && current_owner.buffet.nil?
      unless url_for(only_path: true) == destroy_owner_session_path(only_path: true) || url_for(only_path: true) == new_buffet_path || url_for(only_path: true) == buffets_path
        redirect_to new_buffet_path
      end
    end
  end
end
