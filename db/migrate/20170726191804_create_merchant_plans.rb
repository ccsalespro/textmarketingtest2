class CreateMerchantPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :merchant_plans do |t|
      t.integer :merchant_billing_plan_id
      t.integer :merchant_id
      t.string :name

      t.timestamps
    end
  end
end
