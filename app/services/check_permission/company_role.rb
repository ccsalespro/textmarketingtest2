class CompanyRole

	def create
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("Create Company Roles")
	end

	def view
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("View Company Roles")
	end

	def edit
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("Edit Company Roles")
	end

	def delete
		redirect_to root_path, notice: "Unauthorized Access!" unless @role_permission_names.include?("Delete Company Roles")
	end

end