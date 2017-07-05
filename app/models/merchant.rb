class Merchant < ApplicationRecord
	has_many :merchant_roles
	belongs_to :company
end
