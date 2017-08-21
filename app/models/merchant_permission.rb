class MerchantPermission < ApplicationRecord
	has_many :merchant_role_permissions
	has_many :merchant_roles, through: :merchant_role_permissions
	default_scope -> { order(id: :asc) }
end
