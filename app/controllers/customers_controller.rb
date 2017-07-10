class CustomersController < ApplicationController

	before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :set_merchant

	def index
		@customers = @merchant.customers.all
	end

  def show
  end

  def new
    @customer = @merchant.customers.build
  end

  def edit
  end

  def create
    @customer = @merchant.customers.build(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
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
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
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
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_merchant
      @merchant = Merchant.find_by_subdomain(request.subdomain)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :phone_number, :email, :merchant_id)
    end
end
