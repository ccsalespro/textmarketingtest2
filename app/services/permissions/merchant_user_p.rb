module Permissions
	class MerchantUserP < Permissions::Base

		def create?
			case @user
	    when CompanyUser
	    	@permission_set.include?( CompanyPermission.find_by(id: 13) )
	    when MerchantUser
	    	@permission_set.include?( MerchantPermission.find_by(id: 18) )
	    when Admin
	    	@permission_set.include?( CompanyPermission.find_by(id: 13) )
	    else
				false
	    end
		end

		def show?
			@permission_set.include?( MerchantPermission.find_by(id: 19) )
		end

		def edit?
			@permission_set.include?( MerchantPermission.find_by(id: 20) )
		end

		def delete?
			@permission_set.include?( MerchantPermission.find_by(id: 21) )
		end

	end
end