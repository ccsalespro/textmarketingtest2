class Company < ApplicationRecord
	has_many :company_roles, dependent: :destroy
	has_many :merchants
end
