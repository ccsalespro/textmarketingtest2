class CompanyPlanFieldType < ApplicationRecord
	has_many :company_plan_fields
	has_many :company_plans, through: :company_plan_fields
	has_many :company_field_amounts
end
