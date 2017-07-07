class MerchantUsersController < ApplicationController

	#before_action :require_admin

	def new_merchant_user
		redirect_to root_path unless InviteMerchantUser.new(current_merchant_user, current_admin, current_company_user).check
		merchant = Merchant.find(params[:merchant])
		@merchant_roles = merchant.merchant_roles
	end

	def create_merchant_user
		redirect_to root_path unless InviteMerchantUser.new(current_merchant_user, current_admin, current_company_user).check
		@merchant_admin = MerchantUser.invite!(:email => params[:email], :name => params[:name], :merchant_role_id => params[:merchant_user][:merchant_role_id], :phone_number => params[:phone_number]) unless MerchantUser.find_by_email(params[:email]).present?
		if @merchant_admin.nil?
			redirect_to dashboard_overview_path, notice: 'Email Is Already Connected With Another merchant Account'
		else
			redirect_to dashboard_overview_path, notice: 'Merchant User Invited'
		end
	end

	def destroy_merchant_user
		redirect_to root_path unless CancelMerchantUser.new(current_merchant_user, current_admin).check
		MerchantUser.find(params[:merchant_user]).destroy
    respond_to do |format|
      format.html { redirect_to merchant_path(params[:merchant]), notice: 'Merchant User was successfully canceled.' }
      format.json { head :no_content }
    end
	end

end