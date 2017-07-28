class AddNameToMerchantBillingPlan < ActiveRecord::Migration[5.1]
  def change
    add_column :merchant_billing_plans, :name, :string
  end
end
