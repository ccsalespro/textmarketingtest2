class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :require_admin, if: :devise_controller?
  before_action :load_merchant, if: :merchant_user_signed_in?
  before_action :load_company, if: :company_user_signed_in?

  helper_method :current_user

  def current_user
    current_admin || current_company_user || current_merchant_user
  end 

  private

  def require_admin
  	@admin = current_admin
  	redirect_to root_path unless @admin.present?
  end

  def load_permission_names
    @role_permission_names = []
    if @role != "Admin" && company_user_signed_in?
      @role.company_permissions.each do |cp|
        @role_permission_names << cp.name
      end
      return @role_permission_names
    elsif @role != "Admin" && merchant_user_signed_in?
      @role.merchant_permissions.each do |mp|
        @role_permission_names << mp.name
      end
      return @role_permission_names
    end
  end 

  def determine_user_role
    @role = current_user.role unless current_user == nil
  end

   def load_merchant
      @merchant = current_user().merchant_role.merchant
    end

    def load_company
      @company = current_user().company_role.company
    end

end
