class DashboardController < ApplicationController
	before_action :determine_user_role
	before_action :redirect_if_logged_in, only: [:landing_page]

	def overview
		if company_user_signed_in? || merchant_user_signed_in?
			load_permission_names()
		end

		if merchant_user_signed_in?
			@merchant_users = []
			@merchant.merchant_roles.each do |merchant_role|
				merchant_role.merchant_users.each do |merchant_user|
					@merchant_users << merchant_user
				end
			end
		end

		if company_user_signed_in?
			@company_users = []
			@company.company_roles.each do |company_role|
				company_role.company_users.each do |company_user|
					@company_users << company_user
				end
			end

			@merchants = []
			@company.service_types.each do |service_type|
				service_type.merchant_billing_plans.each do |merchant_plan|
					merchant_plan.merchants.each do |merchant|
						if !@merchants.include?(merchant)
							@merchants << merchant
						end
					end
				end
			end

			@merchant_billing_plans = []
			@company.service_types.each do |service_type|
				service_type.merchant_billing_plans.each do |merchant_plan|
					@merchant_billing_plans << merchant_plan
				end
			end

		end

	end

	def landing_page
	end

	def redirect_if_logged_in
		if admin_signed_in? || company_user_signed_in? || merchant_user_signed_in?
			redirect_to dashboard_overview_path
		end
	end
	
end