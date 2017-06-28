class MerchantRolesController < ApplicationController
  before_action :set_merchant_role, only: [:show, :edit, :update, :destroy]

  # GET /merchant_roles
  # GET /merchant_roles.json
  def index
    @merchant_roles = MerchantRole.all
  end

  # GET /merchant_roles/1
  # GET /merchant_roles/1.json
  def show
  end

  # GET /merchant_roles/new
  def new
    @merchant_role = MerchantRole.new
  end

  # GET /merchant_roles/1/edit
  def edit
  end

  # POST /merchant_roles
  # POST /merchant_roles.json
  def create
    @merchant_role = MerchantRole.new(merchant_role_params)

    respond_to do |format|
      if @merchant_role.save
        format.html { redirect_to @merchant_role, notice: 'Merchant role was successfully created.' }
        format.json { render :show, status: :created, location: @merchant_role }
      else
        format.html { render :new }
        format.json { render json: @merchant_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /merchant_roles/1
  # PATCH/PUT /merchant_roles/1.json
  def update
    respond_to do |format|
      if @merchant_role.update(merchant_role_params)
        format.html { redirect_to @merchant_role, notice: 'Merchant role was successfully updated.' }
        format.json { render :show, status: :ok, location: @merchant_role }
      else
        format.html { render :edit }
        format.json { render json: @merchant_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /merchant_roles/1
  # DELETE /merchant_roles/1.json
  def destroy
    @merchant_role.destroy
    respond_to do |format|
      format.html { redirect_to merchant_roles_url, notice: 'Merchant role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant_role
      @merchant_role = MerchantRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def merchant_role_params
      params.require(:merchant_role).permit(:name, :merchant_id)
    end
end
