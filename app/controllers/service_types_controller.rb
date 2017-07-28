class ServiceTypesController < ApplicationController

	before_action :set_service_type, only: [:show, :edit, :update, :destroy]
  before_action :load_company
  before_action :require_admin

	def index
		@service_types = @company.service_types.all
	end

	def show
	end

	def new
		@service_type = @company.service_types.build
	end

	def create
		@service_type = @company.service_types.build(service_type_params)
		respond_to do |format|
      if @service_type.save
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @service_type }
      else
        format.html { render :new }
        format.json { render json: @service_type.errors, status: :unprocessable_entity }
      end
    end
	end

	def update
    respond_to do |format|
      if @service_type.update(service_type_params)
        format.html { redirect_to @service_type, notice: 'service_type was successfully updated.' }
        format.json { render :show, status: :ok, location: @service_type }
      else
        format.html { render :edit }
        format.json { render json: @service_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @service_type.destroy
    respond_to do |format|
      format.html { redirect_to service_types_path, notice: 'service_type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_type
      @service_type = ServiceType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_type_params
      params.require(:service_type).permit(:name, :company_id)
    end

    def load_company
      @company = Company.find(params[:company_id])
    end 

end