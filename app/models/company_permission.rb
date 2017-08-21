class CompanyPermission < ApplicationRecord
	has_many :company_role_permissions, dependent: :destroy
	has_many :company_roles, through: :company_role_permissions
	default_scope -> { order(id: :asc) }
end
