module Permissions
	class Merchant < Permissions::Base

		def create?
			@permission_set.include?( CompanyPermission.find_by(id: 9) )
		end

		def show?
	    case @user
	    when CompanyUser
	    	@permission_set.include?( CompanyPermission.find_by(id: 10) )
	    when MerchantUser
	    	@permission_set.include?( MerchantPermission.find_by(id: 26) )
	    when Admin
	    	@permission_set.include?( CompanyPermission.find_by(id: 10) )
	    else
				[]
	    end
		end

		def edit?
			@permission_set.include?( CompanyPermission.find_by(id: 11) )
		end

		def delete?
			@permission_set.include?( CompanyPermission.find_by(id: 12) )
		end

	end
end