class MerchantPermissionsController < ApplicationController
  before_action :set_merchant_permission, only: [:show, :edit, :update, :destroy]

  # GET /merchant_permissions
  # GET /merchant_permissions.json
  def index
    @merchant_permissions = MerchantPermission.all
  end

  # GET /merchant_permissions/1
  # GET /merchant_permissions/1.json
  def show
  end

  # GET /merchant_permissions/new
  def new
    @merchant_permission = MerchantPermission.new
  end

  # GET /merchant_permissions/1/edit
  def edit
  end

  # POST /merchant_permissions
  # POST /merchant_permissions.json
  def create
    @merchant_permission = MerchantPermission.new(merchant_permission_params)

    respond_to do |format|
      if @merchant_permission.save
        format.html { redirect_to @merchant_permission, notice: 'Merchant permission was successfully created.' }
        format.json { render :show, status: :created, location: @merchant_permission }
      else
        format.html { render :new }
        format.json { render json: @merchant_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /merchant_permissions/1
  # PATCH/PUT /merchant_permissions/1.json
  def update
    respond_to do |format|
      if @merchant_permission.update(merchant_permission_params)
        format.html { redirect_to @merchant_permission, notice: 'Merchant permission was successfully updated.' }
        format.json { render :show, status: :ok, location: @merchant_permission }
      else
        format.html { render :edit }
        format.json { render json: @merchant_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /merchant_permissions/1
  # DELETE /merchant_permissions/1.json
  def destroy
    @merchant_permission.destroy
    respond_to do |format|
      format.html { redirect_to merchant_permissions_url, notice: 'Merchant permission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant_permission
      @merchant_permission = MerchantPermission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def merchant_permission_params
      params.require(:merchant_permission).permit(:name)
    end
end
