class MerchantPlanFieldType < ApplicationRecord
	has_many :merchant_plan_fields
	has_many :merchant_billing_plans, through: :merchant_plan_fields
	has_many :merchant_field_amounts
end
