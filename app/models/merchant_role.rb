class MerchantRole < ApplicationRecord
	has_many :merchant_users
	has_many :merchant_role_permissions
	has_many :merchant_permissions, through: :merchant_role_permissions
	belongs_to :merchant
end
