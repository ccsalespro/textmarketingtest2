class MerchantRole < CheckPermission

	def create
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("Create Merchant Roles")
	end

	def view
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("View Merchant Roles")
	end

	def edit
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("Edit Merchant Roles")
	end

	def delete
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("Delete Merchant Roles")
	end

end