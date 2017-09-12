module Permissions
	class Template < Permissions::Base

		def create?
			@permission_set.include?( MerchantPermission.find_by(id: 37) )
		end

		def show?
			@permission_set.include?( MerchantPermission.find_by(id: 38) )
		end

		def edit?
			@permission_set.include?( MerchantPermission.find_by(id: 39) )
		end

		def delete?
			@permission_set.include?( MerchantPermission.find_by(id: 40) )
		end

	end
end