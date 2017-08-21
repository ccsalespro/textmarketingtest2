class Template < ApplicationRecord
	belongs_to :merchant
	default_scope -> { order(created_at: :desc) }
end
