class AddCompanyPlanIdToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :company_plan_id, :integer
  end
end
