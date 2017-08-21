class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    redirect_to root_path unless ViewTemplate.new(current_merchant_user, current_admin).check
    @templates = Template.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    redirect_to root_path unless ViewTemplate.new(current_merchant_user, current_admin).check
  end

  def new
    redirect_to root_path unless CreateTemplate.new(current_merchant_user, current_admin).check
    @template = Template.new
  end

  def edit
    redirect_to root_path unless EditTemplate.new(current_merchant_user, current_admin).check
  end

  def create
    redirect_to root_path unless CreateTemplate.new(current_merchant_user, current_admin).check
    @template = Template.new(template_params)

    respond_to do |format|
      if @template.save
        format.html { redirect_to root_path, notice: 'template was successfully created.' }
        format.json { render :show, status: :created, location: @template }
      else
        format.html { render :new }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    redirect_to root_path unless EditTemplate.new(current_merchant_user, current_admin).check
    respond_to do |format|
      if @template.update(template_params)
        format.html { redirect_to root_path, notice: 'template was successfully updated.' }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    redirect_to root_path unless DeleteTemplate.new(current_merchant_user, current_admin).check
    @template.destroy
    respond_to do |format|
      format.html { redirect_to merchant_templates_path(@merchant), notice: 'template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_params
      params.require(:template).permit(:subject, :body, :merchant_id, :created_by, :last_updated_by)
    end
end
