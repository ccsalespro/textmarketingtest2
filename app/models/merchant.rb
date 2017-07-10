class Merchant < ApplicationRecord
	has_many :merchant_roles
	belongs_to :company
	has_many :customers
	has_many :messages
end
