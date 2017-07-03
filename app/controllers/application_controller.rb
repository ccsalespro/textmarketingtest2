class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :require_admin, if: :devise_controller?

  private

  def require_admin
  	@admin = current_admin
  	redirect_to root_path unless @admin.present?
  end

end
