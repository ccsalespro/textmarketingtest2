class CompanyUser < CheckPermission

	def invite
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("Invite Company Users")
	end

	def view
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("View Company Users")
	end

	def edit
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("Edit Company Users")
	end

	def cancel
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("Cancel Company Users")
	end

end