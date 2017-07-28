class CompanyPlanFieldsController < ApplicationController

	before_action :set_company_plan_field, only: [:show, :edit, :update, :destroy]
  before_action :require_admin
  before_action :load_company_plan

	def new
		@company_plan_field = @company_plan.company_plan_fields.build

    @unfiltered_company_plan_field_types = CompanyPlanFieldType.all
    @filtered_company_plan_field_types = []
    @unfiltered_company_plan_field_types.each do |cpft|
      company_plan_field_count = @company_plan.company_plan_fields.where(company_plan_field_type_id: cpft.id).count
      if company_plan_field_count == 0
        @filtered_company_plan_field_types << cpft
      end
    end
	end

	def create
		@company_plan_field = @company_plan.company_plan_fields.build(company_plan_field_params)
		respond_to do |format|
      if @company_plan_field.save
        format.html { redirect_to company_plans_path }
        format.json { render :show, status: :created, location: @company_plan_field }
      else
        format.html { render :new }
        format.json { render json: @company_plan_field.errors, status: :unprocessable_entity }
      end
    end
	end

	def update
    respond_to do |format|
      if @company_plan_field.update(company_plan_field_params)
        format.html { redirect_to company_plans_path, notice: 'company_plan_field was successfully updated.' }
        format.json { render :show, status: :ok, location: @company_plan_field }
      else
        format.html { render :edit }
        format.json { render json: @company_plan_field.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company_plan_field.destroy
    respond_to do |format|
      format.html { redirect_to company_plans_path, notice: 'company_plan_field was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_plan_field
      @company_plan_field = CompanyPlanField.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_plan_field_params
      params.require(:company_plan_field).permit(:amount, :company_plan_field_type_id, :company_plan_id)
    end

    def load_company_plan
      @company_plan = CompanyPlan.find(params[:company_plan_id])
    end 

end