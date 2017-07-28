class CreateCompanyFieldAmounts < ActiveRecord::Migration[5.1]
  def change
    create_table :company_field_amounts do |t|
      t.decimal :amount
      t.integer :company_id
      t.integer :company_plan_field_type_id

      t.timestamps
    end
  end
end
