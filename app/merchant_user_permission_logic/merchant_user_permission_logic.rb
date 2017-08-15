class MerchantUserPermissionLogic

	def initialize(user=nil, admin, company_user=nil)
	  @user = user
	  @admin = admin
	  @company_user = company_user
	  @permission_set = permission_set(user, admin, company_user)
	end

	def permission_set(user, admin, company_user)
		if user.present?
			user_role = MerchantRole.find_by(id: user.merchant_role_id)
	  	return user_role.merchant_permissions
	  elsif admin.present?
	  	return MerchantPermission.all
	  elsif company_user.present?
	  	company_user_role = CompanyRole.find_by(id: company_user.company_role_id)
	  	return  company_user_role.company_permissions
	  else
	  	return Array([])
		end
	end

end