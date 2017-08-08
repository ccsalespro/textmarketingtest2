class MessagesPermissionLogic

	def initialize(user, admin)
	  @user = user
	  @admin = admin
	  @permission_set = permission_set(user, admin)
	end

	def permission_set(user, admin)
		if user.present?
			user_role = MerchantRole.find_by(id: user.merchant_role_id)
	  	return user_role.merchant_permissions
	  elsif admin.present?
	  	return MerchantPermission.all
	  else
	  	return Array([])
		end
	end

end