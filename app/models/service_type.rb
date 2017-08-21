class ServiceType < ApplicationRecord
	belongs_to :company
	has_many :merchant_billing_plans
	default_scope -> { order(created_at: :desc) }
end
