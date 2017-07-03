class LoadRoles

	def load_company_roles(company)
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

end