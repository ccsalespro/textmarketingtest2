class CompanyUsersController < ApplicationController

	before_action :require_admin

	def new_company_user
		company = Company.find(params[:company])
		@company_roles = company.company_roles
	end

	def create_company_user
		@company_admin = CompanyUser.invite!(:email => params[:email], :name => params[:name], :company_role_id => params[:company_user][:company_role_id], :phone_number => params[:phone_number]) unless CompanyUser.find_by_email(params[:email]).present?
		if @company_admin.nil?
			redirect_to dashboard_overview_path, notice: 'Email Is Already Connected With Another Company Account'
		else
			redirect_to dashboard_overview_path, notice: 'Company User Invited'
		end
	end

end