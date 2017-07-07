class CompanyPermissionLogic

	def initialize(user, admin)
	  @user = user
	  @admin = admin
	  @permission_set = permission_set(user, admin)
	end

	def permission_set(user, admin)
		if user.present?
			user_role = CompanyRole.find_by(id: user.company_role_id)
	  	return user_role.company_permissions
	  elsif admin.present?
	  	return CompanyPermission.all
	  else
	  	return Array([])
		end
	end

end