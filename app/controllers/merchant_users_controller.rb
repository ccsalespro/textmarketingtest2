class MerchantUsersController < ApplicationController

	before_action :set_merchant_user, only: [:edit, :update, :show]

	def new_merchant_user
		@merchant = Merchant.find_by_id(params[:merchant].to_i)
		redirect_to root_path unless InviteMerchantUser.new(current_merchant_user, current_admin, current_company_user).check
		@merchant_roles = @merchant.merchant_roles
	end

	def create_merchant_user
		redirect_to root_path unless InviteMerchantUser.new(current_merchant_user, current_admin, current_company_user).check
		@merchant_admin = MerchantUser.invite!(:email => params[:email], :name => params[:name], :merchant_role_id => params[:merchant_user][:merchant_role_id], :phone_number => params[:phone_number]) unless MerchantUser.find_by_email(params[:email]).present?
		if @merchant_admin.nil?
			redirect_to dashboard_overview_path, notice: 'Email Is Already Connected With Another Merchant Account'
		else
			redirect_to dashboard_overview_path, notice: 'Merchant User Invited'
		end
	end

	def index
		@merchant_roles = @merchant.merchant_roles.all
	end

	def show

	end

	def edit
		redirect_to root_path unless EditMerchantUser.new(current_merchant_user, current_admin).check
    merchant = Merchant.find_by(id: @merchant_user.merchant_role.merchant_id)
    @merchant_roles = merchant.merchant_roles
  end

  def update
  	redirect_to root_path unless EditMerchantUser.new(current_merchant_user, current_admin).check
    respond_to do |format|
      if @merchant_user.update(merchant_user_params)
        format.html { redirect_to root_path, notice: 'Merchant User Updated' }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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

	private

	def merchant_user_params
      params.require(:merchant_user).permit(:name, :email, :merchant_role_id, :phone_number, :password, :password_confirmation)
    end

    def set_merchant_user
      @merchant_user = MerchantUser.find(params[:id])
    end

end