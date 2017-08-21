class Message < ApplicationRecord
	has_many :customer_messages
	has_many :customers, through: :customer_messages
	belongs_to :merchant
	default_scope -> { order(created_at: :desc) }
end
