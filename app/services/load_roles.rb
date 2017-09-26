class LoadRoles

	def run(company_or_merchant)
		case company_or_merchant
		when Company
			company(company_or_merchant)
		when Merchant
			merchant(company_or_merchant)
		else
			raise StandardError, "You didn't give me a Company or a Merchant"
		end
	end

	private

	def company(company)
		@all_company_permissions = CompanyPermission.all

		@base_role = company.company_roles.build
		@base_role.name = "Sales Rep"
		@base_role.save

		@admin_role = company.company_roles.build
		@admin_role.name = "Company Admin"
		@admin_role.save

		@all_company_permissions.each do |cp|
			admin_permission = @admin_role.company_role_permissions.build
			admin_permission.company_permission_id = cp.id
			admin_permission.save
		end

	end

	def merchant(merchant)
		@all_merchant_permissions = MerchantPermission.all

		@base_role = merchant.merchant_roles.build
		@base_role.name = "Employee"
		@base_role.save

		@admin_role = merchant.merchant_roles.build
		@admin_role.name = "Merchant Admin"
		@admin_role.save

		@all_merchant_permissions.each do |mp|
			admin_permission = @admin_role.merchant_role_permissions.build
			admin_permission.merchant_permission_id = mp.id
			admin_permission.save
		end
	end

end