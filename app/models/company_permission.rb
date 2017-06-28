class CompanyPermission < ApplicationRecord
	has_many :company_role_permissions
	has_many :company_roles, through: :company_role_permissions
end
