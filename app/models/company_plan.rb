class CompanyPlan < ApplicationRecord
	has_many :companies
	has_many :company_plan_fields
	has_many :company_plan_field_types, through: :company_plan_fields
	default_scope -> { order(created_at: :desc) }
end
