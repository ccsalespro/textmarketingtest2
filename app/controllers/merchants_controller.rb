class MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :edit, :update, :destroy]
  before_action :load_company
  before_action :load_merchant_billing_plan

  # GET /merchants
  # GET /merchants.json
  def index
    redirect_to root_path unless ViewMerchant.new(current_company_user, current_admin).check
    @merchants = []
  end

  # GET /merchants/1
  # GET /merchants/1.json
  def show
    redirect_to root_path unless ViewMerchant.new(current_company_user, current_admin, current_merchant_user).check
    determine_user_role()
    load_permission_names()
  end

  # GET /merchants/new
  def new
    redirect_to root_path unless CreateMerchant.new(current_company_user, current_admin).check

    boot_twilio()
    @numbers = @client.available_phone_numbers.get('US').local.list(:area_code => '814')
    @merchant = @merchant_billing_plan.merchants.build
  end

  # GET /merchants/1/edit
  def edit
    redirect_to root_path unless EditMerchant.new(current_company_user, current_admin).check
  end

  # POST /merchants
  # POST /merchants.json
  def create
    redirect_to root_path unless CreateMerchant.new(current_company_user, current_admin).check
    @merchant = @merchant_billing_plan.merchants.build(merchant_params)
    LoadRoles.new.load_merchant_roles(@merchant)

    @merchant_plan = @merchant.merchant_plans.build
    @merchant_plan.name = @merchant_billing_plan.name
    @merchant_plan.merchant_billing_plan_id = @merchant_billing_plan.id
    @merchant_plan.save

    boot_twilio()
    @client.incoming_phone_numbers.create(:phone_number => @merchant.phone_number)
    @client.incoming_phone_numbers.get(@merchant.phone_number).update({'SmsUrl' => 'https://textmarketingresellers.herokuapp.com/messages/reply'})

    respond_to do |format|
      if @merchant.save
        format.html { redirect_to root_path, notice: 'Merchant was successfully created.' }
        format.json { render :show, status: :created, location: @merchant }
      else
        format.html { render :new }
        format.json { render json: @merchant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /merchants/1
  # PATCH/PUT /merchants/1.json
  def update
    redirect_to root_path unless EditMerchant.new(current_company_user, current_admin).check
    respond_to do |format|
      if @merchant.update(merchant_params)
        format.html { redirect_to root_path, notice: 'Merchant was successfully updated.' }
        format.json { render :show, status: :ok, location: @merchant }
      else
        format.html { render :edit }
        format.json { render json: @merchant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /merchants/1
  # DELETE /merchants/1.json
  def destroy
    redirect_to root_path unless DeleteMerchant.new(current_company_user, current_admin).check
    @merchant.destroy
    respond_to do |format|
      format.html { redirect_to merchants_url, notice: 'Merchant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant
      @merchant = Merchant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def merchant_params
      params.require(:merchant).permit(:name, :phone_number, :merchant_billing_plan_id)
    end

    def boot_twilio
      account_sid = ENV["TWILIO_SID"]
      auth_token = ENV["TWILIO_TOKEN"]
      @client = Twilio::REST::Client.new account_sid, auth_token
    end

    def load_company
      @company = Company.find(params[:company_id])
    end

    def load_merchant_billing_plan
      @merchant_billing_plan = MerchantBillingPlan.find(params[:merchant_billing_plan_id])
    end
end
