class MerchantRolesController < ApplicationController
  before_action :set_merchant_role, only: [:show, :edit, :update, :destroy]

  # GET /merchant_roles
  # GET /merchant_roles.json
  def index
    redirect_to root_path unless ViewMerchantRole.new(current_merchant_user, current_admin).check
    determine_user_role()
    load_permission_names()
    @merchant_roles = @merchant.merchant_roles.all
  end

  # GET /merchant_roles/1
  # GET /merchant_roles/1.json
  def show
    redirect_to root_path unless ViewMerchantRole.new(current_merchant_user, current_admin).check
    @merchant_permissions = MerchantPermission.all
  end

  # GET /merchant_roles/new
  def new
    redirect_to root_path unless CreateMerchantRole.new(current_merchant_user, current_admin).check
    @merchant_role = @merchant.merchant_roles.build
  end

  # GET /merchant_roles/1/edit
  def edit
    redirect_to root_path unless EditMerchantRole.new(current_merchant_user, current_admin).check
  end

  # POST /merchant_roles
  # POST /merchant_roles.json
  def create
    redirect_to root_path unless CreateMerchantRole.new(current_merchant_user, current_admin).check
    @merchant_role = @merchant.merchant_roles.build(merchant_role_params)

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
    redirect_to root_path unless EditMerchantRole.new(current_merchant_user, current_admin).check
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
    redirect_to root_path unless DeleteMerchantRole.new(current_merchant_user, current_admin).check
    @merchant_role.destroy
    respond_to do |format|
      format.html { redirect_to merchant_roles_url, notice: 'Merchant role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_permission
    redirect_to root_path unless EditMerchantRole.new(current_merchant_user, current_admin).check
    MerchantRolePermission.create(merchant_role_id: params[:merchant_role_id], merchant_permission_id: params[:merchant_permission_id])
    redirect_to merchant_role_path( MerchantRole.find_by_id(params[:merchant_role_id]) ), notice: "Permission Added To Role"
  end

  def remove_permission
    redirect_to root_path unless EditMerchantRole.new(current_merchant_user, current_admin).check
    @role_permission = MerchantRolePermission.find_by_merchant_role_id_and_merchant_permission_id(params[:merchant_role_id], params[:merchant_permission_id])
    @role_permission.destroy
    redirect_to merchant_role_path( MerchantRole.find_by_id(params[:merchant_role_id]) ), notice: "Permission Removed From Role"
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
