class CompanyPlansController < ApplicationController

	before_action :set_company_plan, only: [:show, :edit, :update, :destroy]
  before_action :require_admin

	def index
		@company_plans = CompanyPlan.all
	end

	def show
    @company_plan_fields = @company_plan.company_plan_fields.all
	end

	def new
		@company_plan = CompanyPlan.new
	end

	def create
		@company_plan = CompanyPlan.new(company_plan_params)
		respond_to do |format|
      if @company_plan.save
        format.html { redirect_to new_company_plan_company_plan_field_path(@company_plan) }
        format.json { render :show, status: :created, location: @company_plan }
      else
        format.html { render :new }
        format.json { render json: @company_plan.errors, status: :unprocessable_entity }
      end
    end
	end

	def update
    respond_to do |format|
      if @company_plan.update(company_plan_params)
        format.html { redirect_to @company_plan, notice: 'company_plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @company_plan }
      else
        format.html { render :edit }
        format.json { render json: @company_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company_plan.destroy
    respond_to do |format|
      format.html { redirect_to company_plans_path, notice: 'company_plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_plan
      @company_plan = CompanyPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_plan_params
      params.require(:company_plan).permit(:name)
    end

end