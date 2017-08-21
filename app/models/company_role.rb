class CompanyRole < ApplicationRecord
	has_many :company_users
	has_many :company_role_permissions
	has_many :company_permissions, through: :company_role_permissions
	belongs_to :company
	default_scope -> { order(created_at: :desc) }
end
