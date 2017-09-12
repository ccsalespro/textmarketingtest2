module Permissions
	class MerchantRole < Permissions::Base

		def create?
			@permission_set.include?( MerchantPermission.find_by(id: 22) )
		end

		def show?
			@permission_set.include?( MerchantPermission.find_by(id: 23) )
		end

		def edit?
			@permission_set.include?( MerchantPermission.find_by(id: 24) )
		end

		def delete?
			@permission_set.include?( MerchantPermission.find_by(id: 25) )
		end

	end
end