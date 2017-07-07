class MerchantPermissionLogic

	def initialize(user, admin, merchant=nil)
	  @user = user
	  @admin = admin
	  @merchant = merchant
	  @permission_set = permission_set(user, admin, merchant)
	end

	def permission_set(user, admin, merchant)
		if user.present?
			user_role = CompanyRole.find_by(id: user.company_role_id)
	  	return user_role.company_permissions
	  elsif admin.present?
	  	return CompanyPermission.all
	  elsif merchant.present?
	  	merchant_role = MerchantRole.find_by(id: merchant.merchant_role_id)
	  	return  merchant_role.merchant_permissions
	  else
	  	return Array([])
		end
	end

end