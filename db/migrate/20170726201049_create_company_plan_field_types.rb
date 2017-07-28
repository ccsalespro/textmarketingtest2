class CreateCompanyPlanFieldTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :company_plan_field_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
