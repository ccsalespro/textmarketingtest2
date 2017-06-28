class CompanyRolePermission < ApplicationRecord
	belongs_to :company_role
	belongs_to :company_permission
end
