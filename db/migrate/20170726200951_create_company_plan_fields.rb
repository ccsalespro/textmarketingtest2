class CreateCompanyPlanFields < ActiveRecord::Migration[5.1]
  def change
    create_table :company_plan_fields do |t|
      t.integer :company_plan_id
      t.integer :company_plan_field_type_id
      t.decimal :amount

      t.timestamps
    end
  end
end
