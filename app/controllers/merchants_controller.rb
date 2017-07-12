class MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :edit, :update, :destroy]

  # GET /merchants
  # GET /merchants.json
  def index
    redirect_to root_path unless ViewMerchant.new(current_company_user, current_admin).check
    @company = Company.find_by_subdomain(request.subdomain)
    @merchants = @company.merchants.all
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
    @company = Company.find_by_subdomain(request.subdomain)
    boot_twilio()
    #@numbers = @client.available_phone_numbers.get("US").local.list
    @numbers = ["+18147933052", "+18145024125", "+18142066292"]
    @merchant = @company.merchants.build
  end

  # GET /merchants/1/edit
  def edit
    redirect_to root_path unless EditMerchant.new(current_company_user, current_admin).check
  end

  # POST /merchants
  # POST /merchants.json
  def create
    redirect_to root_path unless CreateMerchant.new(current_company_user, current_admin).check
    @company = Company.find_by_subdomain(request.subdomain)
    @merchant = @company.merchants.build(merchant_params)
    LoadRoles.new.load_merchant_roles(@merchant)

    respond_to do |format|
      if @merchant.save
        format.html { redirect_to @merchant, notice: 'Merchant was successfully created.' }
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
        format.html { redirect_to @merchant, notice: 'Merchant was successfully updated.' }
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
      params.require(:merchant).permit(:subdomain, :company_id, :phone_number)
    end

    def boot_twilio
      account_sid = ENV["TWILIO_SID"]
      auth_token = ENV["TWILIO_TOKEN"]
      @client = Twilio::REST::Client.new account_sid, auth_token
    end
end
