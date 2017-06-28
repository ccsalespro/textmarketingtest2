class MerchantRolePermission < ApplicationRecord
	belongs_to :merchant_role
	belongs_to :merchant_permission
end
