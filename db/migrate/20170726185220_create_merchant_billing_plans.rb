class CreateMerchantBillingPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :merchant_billing_plans do |t|
      t.integer :service_type_id

      t.timestamps
    end
  end
end
