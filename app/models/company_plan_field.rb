class CompanyPlanField < ApplicationRecord
	belongs_to :company_plan
	belongs_to :company_plan_field_type
end
