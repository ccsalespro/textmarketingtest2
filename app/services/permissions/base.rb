module Permissions
	class Base

		def initialize(user)
		  @user = user
		  @permission_set = permission_set(user)
		end

		def permission_set(user)
			case user
			when CompanyUser
				user.company_role.company_permissions
			when MerchantUser
				user.merchant_role.merchant_permissions
			when Admin
				CompanyPermission.all
			else
				[]
			end
		end

		def create?
			case user
			when Admin
				true
			else
				false
			end
		end

		def show?
			create?
		end

		def edit?
			create?
		end

		def delete?
			create?
		end

	end
end