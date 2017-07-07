class DashboardController < ApplicationController
	before_action :determine_user_role

	def overview
		@company = Company.find_by_subdomain(request.subdomain)
		@merchant = Merchant.find_by_subdomain(request.subdomain)
		if company_user_signed_in? || merchant_user_signed_in?
			load_permission_names()
		end
	end
end