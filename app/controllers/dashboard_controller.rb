class DashboardController < ApplicationController
	def overview
		@company = Company.find_by_subdomain(request.subdomain)
	end
end