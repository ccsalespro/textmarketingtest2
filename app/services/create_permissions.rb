class CreatePermissions

	def company
		# Company Users Permissions
		CompanyPermission.create(name: "Invite Company Users")
		CompanyPermission.create(name: "View Company Users")
		CompanyPermission.create(name: "Edit Company Users")
		CompanyPermission.create(name: "Cancel Company Users")

		# Company Roles Permissions
		CompanyPermission.create(name: "Create Company Roles")
		CompanyPermission.create(name: "View Company Roles")
		CompanyPermission.create(name: "Edit Company Roles")
		CompanyPermission.create(name: "Delete Company Roles")

		# CRUD For Merchants Permissions
		CompanyPermission.create(name: "Create Merchants")
		CompanyPermission.create(name: "View Merchants")
		CompanyPermission.create(name: "Edit Merchants")
		CompanyPermission.create(name: "Delete Merchants")

		# Merchant Users Permissions
		CompanyPermission.create(name: "Invite Merchant Users")
		CompanyPermission.create(name: "View Merchant Users")
		CompanyPermission.create(name: "Edit Merchant Users")
		CompanyPermission.create(name: "Cancel Merchant Users")
	end

	def merchant
		# Merchant Users Permissions
		MerchantPermission.create(name: "Invite Merchant Users")
		MerchantPermission.create(name: "View Merchant Users")
		MerchantPermission.create(name: "Edit Merchant Users")
		MerchantPermission.create(name: "Cancel Merchant Users")

		# Merchant Roles Permissions
		MerchantPermission.create(name: "Create Merchant Roles")
		MerchantPermission.create(name: "View Merchant Roles")
		MerchantPermission.create(name: "Edit Merchant Roles")
		MerchantPermission.create(name: "Delete Merchant Roles")
	end

end