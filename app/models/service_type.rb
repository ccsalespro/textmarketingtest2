class ServiceType < ApplicationRecord
	belongs_to :company
	has_many :merchant_billing_plans
end
