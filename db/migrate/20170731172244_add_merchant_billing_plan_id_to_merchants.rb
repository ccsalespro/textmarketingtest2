class AddMerchantBillingPlanIdToMerchants < ActiveRecord::Migration[5.1]
  def change
    add_column :merchants, :merchant_billing_plan_id, :integer
  end
end
