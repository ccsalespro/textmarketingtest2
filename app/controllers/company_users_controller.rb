class CompanyUsersController < ApplicationController

	#before_action :require_admin

	def new_company_user
		company = Company.find(params[:company])
		@company_roles = company.company_roles
	end

	def create_company_user
		@company_user = CompanyUser.invite!(:email => params[:email], :name => params[:name], :company_role_id => params[:company_user][:company_role_id], :phone_number => params[:phone_number]) unless CompanyUser.find_by_email(params[:email]).present?
		if @company_user.nil?
			redirect_to dashboard_overview_path, notice: 'Email Is Already Connected With Another Company Account'
		else
			redirect_to dashboard_overview_path, notice: 'Company User Invited'
		end
	end

	def destroy_company_user
		@company_user = CompanyUser.find(params[:company_user])
		@company_user.destroy
    respond_to do |format|
      format.html { redirect_to company_path(params[:company]), notice: 'Company User was successfully canceled.' }
      format.json { head :no_content }
    end
	end

end