class CreateMerchantFieldAmounts < ActiveRecord::Migration[5.1]
  def change
    create_table :merchant_field_amounts do |t|
      t.decimal :amount
      t.integer :merchant_id
      t.integer :merchant_plan_field_type_id

      t.timestamps
    end
  end
end
