class Company < ApplicationRecord
	has_many :company_roles, dependent: :destroy
	has_many :service_types
	has_many :company_charges
	has_many :merchant_plans
	belongs_to :company_plan
	default_scope -> { order(created_at: :desc) }
end
