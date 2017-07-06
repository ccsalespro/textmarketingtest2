class CompanyRolePermissionLogic

	def initialize(user)
	  @user = user
	  @permission_set = permission_set(user)
	end

	def permission_set(user)
		user_role = CompanyRole.find_by(id: user.company_role_id)
	  permission_set_array = [ ]
	  CompanyPermission.all.each do |cp|
	    if CompanyRolePermission.where(company_role_id: user_role.id).where(company_permission_id: cp.id)
		      permission_set_array << cp
		  end
			return permission_set_array
		end
	end

end