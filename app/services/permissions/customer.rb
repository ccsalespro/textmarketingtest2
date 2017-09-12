module Permissions
	class Customer < Permissions::Base

		def create?
			@permission_set.include?( MerchantPermission.find_by(id: 32) )
		end

		def show?
			@permission_set.include?( MerchantPermission.find_by(id: 33) )
		end

		def edit?
			@permission_set.include?( MerchantPermission.find_by(id: 34) )
		end

		def delete?
			@permission_set.include?( MerchantPermission.find_by(id: 35) )
		end

	end
end