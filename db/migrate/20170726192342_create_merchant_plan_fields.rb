class CreateMerchantPlanFields < ActiveRecord::Migration[5.1]
  def change
    create_table :merchant_plan_fields do |t|
      t.decimal :amount
      t.integer :merchant_billing_plan_id
      t.integer :merchant_plan_field_type_id

      t.timestamps
    end
  end
end
