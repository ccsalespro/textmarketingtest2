class CompanyRolesController < ApplicationController
  before_action :set_company_role, only: [:show, :edit, :update, :destroy]
  before_action :set_company, only: [:index, :new, :create]

  # GET /company_roles
  # GET /company_roles.json
  def index
    redirect_to root_path unless ViewCompanyRole.new(current_company_user, current_admin).check
    determine_user_role()
    load_permission_names()
    @company_roles = @company.company_roles.all
  end

  # GET /company_roles/1
  # GET /company_roles/1.json
  def show
    redirect_to root_path unless ViewCompanyRole.new(current_company_user, current_admin).check
    @company_permissions = CompanyPermission.all
  end

  # GET /company_roles/new
  def new
    redirect_to root_path unless CreateCompanyRole.new(current_company_user, current_admin).check
    @company_role = @company.company_roles.build
  end

  # GET /company_roles/1/edit
  def edit
    redirect_to root_path unless EditCompanyRole.new(current_company_user, current_admin).check
  end

  # POST /company_roles
  # POST /company_roles.json
  def create
    redirect_to root_path unless CreateCompanyRole.new(current_company_user, current_admin).check
    @company_role = @company.company_roles.build(company_role_params)

    respond_to do |format|
      if @company_role.save
        format.html { redirect_to @company_role, notice: 'Company role was successfully created.' }
        format.json { render :show, status: :created, location: @company_role }
      else
        format.html { render :new }
        format.json { render json: @company_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /company_roles/1
  # PATCH/PUT /company_roles/1.json
  def update
    redirect_to root_path unless EditCompanyRole.new(current_company_user, current_admin).check
    respond_to do |format|
      if @company_role.update(company_role_params)
        format.html { redirect_to @company_role, notice: 'Company role was successfully updated.' }
        format.json { render :show, status: :ok, location: @company_role }
      else
        format.html { render :edit }
        format.json { render json: @company_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_roles/1
  # DELETE /company_roles/1.json
  def destroy
    redirect_to root_path unless DeleteCompanyRole.new(current_company_user, current_admin).check
    @company_role.destroy
    respond_to do |format|
      format.html { redirect_to company_roles_url, notice: 'Company role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_permission
    CompanyRolePermission.create(company_role_id: params[:company_role_id], company_permission_id: params[:company_permission_id])
    redirect_to company_role_path( CompanyRole.find_by_id(params[:company_role_id]) ), notice: "Permission Added To Role"
  end

  def remove_permission
    @role_permission = CompanyRolePermission.find_by_company_role_id_and_company_permission_id(params[:company_role_id], params[:company_permission_id])
    @role_permission.destroy
    redirect_to company_role_path( CompanyRole.find_by_id(params[:company_role_id]) ), notice: "Permission Removed From Role"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_role
      @company_role = CompanyRole.find(params[:id])
    end

    def set_company
      @company = Company.find_by_subdomain(request.subdomain)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_role_params
      params.require(:company_role).permit(:name, :company_id)
    end
end
