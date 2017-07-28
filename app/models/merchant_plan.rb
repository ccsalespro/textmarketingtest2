class MerchantPlan < ApplicationRecord
	belongs_to :merchant_billing_plan
	belongs_to :merchant
end
