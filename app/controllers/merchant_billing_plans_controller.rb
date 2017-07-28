class MerchantBillingPlansController < ApplicationController

	before_action :set_merchant_billing_plan, only: [:show, :edit, :update, :destroy]
  before_action :load_company

	def index
		@service_types = @company.service_types.all
	end

	def show
	end

	def new
		@merchant_billing_plan = MerchantBillingPlan.new
	end

	def create
		@merchant_billing_plan = MerchantBillingPlan.new(merchant_billing_plan_params)
		respond_to do |format|
      if @merchant_billing_plan.save
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @merchant_billing_plan }
      else
        format.html { render :new }
        format.json { render json: @merchant_billing_plan.errors, status: :unprocessable_entity }
      end
    end
	end

	def update
    respond_to do |format|
      if @merchant_billing_plan.update(merchant_billing_plan_params)
        format.html { redirect_to @merchant_billing_plan, notice: 'merchant_billing_plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @merchant_billing_plan }
      else
        format.html { render :edit }
        format.json { render json: @merchant_billing_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @merchant_billing_plan.destroy
    respond_to do |format|
      format.html { redirect_to merchant_billing_plans_path, notice: 'merchant_billing_plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant_billing_plan
      @merchant_billing_plan = MerchantBillingPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def merchant_billing_plan_params
      params.require(:merchant_billing_plan).permit(:name, :service_type_id)
    end

    def load_company
      @company = Company.find(params[:company_id])
    end

end