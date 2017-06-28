class CompanyRolesController < ApplicationController
  before_action :set_company_role, only: [:show, :edit, :update, :destroy]

  # GET /company_roles
  # GET /company_roles.json
  def index
    @company_roles = CompanyRole.all
  end

  # GET /company_roles/1
  # GET /company_roles/1.json
  def show
  end

  # GET /company_roles/new
  def new
    @company_role = CompanyRole.new
  end

  # GET /company_roles/1/edit
  def edit
  end

  # POST /company_roles
  # POST /company_roles.json
  def create
    @company_role = CompanyRole.new(company_role_params)

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
    @company_role.destroy
    respond_to do |format|
      format.html { redirect_to company_roles_url, notice: 'Company role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_role
      @company_role = CompanyRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_role_params
      params.require(:company_role).permit(:name, :company_id)
    end
end
