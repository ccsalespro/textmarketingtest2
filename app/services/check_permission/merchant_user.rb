class MerchantUser < CheckPermission

	def invite
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("Invite Merchant Users")
	end

	def view
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("View Merchant Users")
	end

	def edit
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("Edit Merchant Users")
	end

	def cancel
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("Cancel Merchant Users")
	end

end