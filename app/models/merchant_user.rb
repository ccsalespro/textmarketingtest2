class MerchantUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	belongs_to :merchant_role
	default_scope -> { order(created_at: :desc) }

	def role
  	merchant_role
  end

end
