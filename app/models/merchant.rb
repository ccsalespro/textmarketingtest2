class Merchant < ApplicationRecord
	has_many :merchant_roles
	has_many :customers
	has_many :messages
	has_many :templates
	has_many :merchant_field_amounts
	has_many :merchant_charges

	has_many :merchant_plans
	has_many :merchant_billing_plans, through: :merchant_plans
	default_scope -> { order(created_at: :desc) }
end
