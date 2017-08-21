class MerchantBillingPlan < ApplicationRecord
	belongs_to :service_type
	has_many :merchant_plans
	has_many :merchants, through: :merchant_plans
	has_many :merchant_plan_fields
	has_many :merchant_plan_field_types, through: :merchant_plan_fields
	default_scope -> { order(created_at: :desc) }
end
