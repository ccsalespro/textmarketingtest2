class MerchantPlanField < ApplicationRecord
	belongs_to :merchant_billing_plan
	belongs_to :merchant_plan_field_type
end
