include ActionView::Helpers::NumberHelper
class CustomersController < ApplicationController

	before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :load_merchant

	def index
    redirect_to root_path unless Permissions::Customer.new(current_user).show?
		@customers = @merchant.customers.all
	end

  def show
     redirect_to root_path unless Permissions::Customer.new(current_user).show?
  end

  def new
     redirect_to root_path unless Permissions::Customer.new(current_user).create?
    @customer = @merchant.customers.build
  end

  def edit
     redirect_to root_path unless Permissions::Customer.new(current_user).edit?
  end

  def create
    redirect_to root_path unless Permissions::Customer.new(current_user).create?
    @customer = @merchant.customers.build(customer_params)
    @number = number_to_phone(params[:customer][:phone_number], delimiter: "", area_code: true).gsub("+1", "")
    @customer.phone_number = number_to_phone(@number, delimiter: "", country_code: 1).tr('-() ', '')
    raise
    respond_to do |format|
      if @customer.save
        TwilioLogic.new.send_permission_to_text_request(@customer)
        format.html { redirect_to root_path, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
     redirect_to root_path unless Permissions::Customer.new(current_user).edit?
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to root_path, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
     redirect_to root_path unless Permissions::Customer.new(current_user).delete?
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to merchant_customers_path(@merchant), notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    def load_merchant
      @merchant = Merchant.find(params[:merchant_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :phone_number, :email, :merchant_id)
    end
end
