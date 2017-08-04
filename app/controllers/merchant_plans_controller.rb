class MerchantPlansController < ApplicationController

	before_action :set_merchant_plan, only: [:show, :edit, :update, :destroy]
  before_action :load_company
  before_action :load_merchant_billing_plan
  before_action :load_merchant

	def index
		@service_types = @company.service_types.all
	end

	def show
	end

	def new
		@merchant_plan = @merchant.merchant_plans.build
    @merchant_billing_plans = []
    @company.service_types.each do |st|
      st.merchant_billing_plans.each do |mbp|
        @merchant_billing_plans << mbp
      end 
    end
	end

	def create
    #redirect_to new_company_merchant_billing_plan_merchant_merchant_plan_path(@company, @merchant_billing_plan, @merchant), notice: "Merchant Already Has That Plan" unless MerchantPlansLogic.new.check_merchants_merchant_plans(@merchant, @merchant_billing_plan, params[:merchant_plan][:merchant_billing_plan_id])

    if MerchantPlansLogic.new.check_merchants_merchant_plans(@merchant, @merchant_billing_plan, params[:merchant_plan][:merchant_billing_plan_id])
  		@merchant_plan = @merchant.merchant_plans.build(merchant_plan_params)
      @merchant_plan.name = MerchantBillingPlan.find_by_id(params[:merchant_plan][:merchant_billing_plan_id]).name
      respond_to do |format|
        if @merchant_plan.save
          format.html { redirect_to root_path }
          format.json { render :show, status: :created, location: @merchant_plan }
        else
          format.html { render :new }
          format.json { render json: @merchant_plan.errors, status: :unprocessable_entity }
        end
      end
    end
	end

	def update
    respond_to do |format|
      if @merchant_plan.update(merchant_plan_params)
        format.html { redirect_to @merchant_plan, notice: 'merchant_plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @merchant_plan }
      else
        format.html { render :edit }
        format.json { render json: @merchant_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @merchant_plan.destroy
    respond_to do |format|
      format.html { redirect_to merchant_plans_path, notice: 'merchant_plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant_plan
      @merchant_plan = MerchantPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def merchant_plan_params
      params.require(:merchant_plan).permit(:name, :merchant_id, :merchant_billing_plan_id)
    end

    def load_company
      @company = Company.find(params[:company_id])
    end

    def load_merchant_billing_plan
      @merchant_billing_plan = MerchantBillingPlan.find(params[:merchant_billing_plan_id])
    end

    def load_merchant
      @merchant = Merchant.find(params[:merchant_id])
    end

end