class MerchantFieldAmount < ApplicationRecord
	belongs_to :merchant
	belongs_to :merchant_plan_field_type
end
