class CompanyFieldAmount < ApplicationRecord
	belongs_to :company
	belongs_to :company_plan_field_type
end
