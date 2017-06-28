class CompanyPermissionsController < ApplicationController
  before_action :set_company_permission, only: [:show, :edit, :update, :destroy]

  # GET /company_permissions
  # GET /company_permissions.json
  def index
    @company_permissions = CompanyPermission.all
  end

  # GET /company_permissions/1
  # GET /company_permissions/1.json
  def show
  end

  # GET /company_permissions/new
  def new
    @company_permission = CompanyPermission.new
  end

  # GET /company_permissions/1/edit
  def edit
  end

  # POST /company_permissions
  # POST /company_permissions.json
  def create
    @company_permission = CompanyPermission.new(company_permission_params)

    respond_to do |format|
      if @company_permission.save
        format.html { redirect_to @company_permission, notice: 'Company permission was successfully created.' }
        format.json { render :show, status: :created, location: @company_permission }
      else
        format.html { render :new }
        format.json { render json: @company_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /company_permissions/1
  # PATCH/PUT /company_permissions/1.json
  def update
    respond_to do |format|
      if @company_permission.update(company_permission_params)
        format.html { redirect_to @company_permission, notice: 'Company permission was successfully updated.' }
        format.json { render :show, status: :ok, location: @company_permission }
      else
        format.html { render :edit }
        format.json { render json: @company_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_permissions/1
  # DELETE /company_permissions/1.json
  def destroy
    @company_permission.destroy
    respond_to do |format|
      format.html { redirect_to company_permissions_url, notice: 'Company permission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_permission
      @company_permission = CompanyPermission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_permission_params
      params.require(:company_permission).permit(:name)
    end
end
