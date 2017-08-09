class DashboardController < ApplicationController
	before_action :determine_user_role

	def overview
		if company_user_signed_in? || merchant_user_signed_in?
			load_permission_names()
		end

		@merchant_users = []
		@merchant.merchant_roles.each do |merchant_role|
			merchant_role.merchant_users.each do |merchant_user|
				@merchant_users << merchant_user
			end
		end

	end

	def landing_page
	end
	
end