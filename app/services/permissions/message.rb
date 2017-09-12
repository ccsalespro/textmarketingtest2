module Permissions
	class Message < Permissions::Base

		def create?
			# Send Messages Are Included
			@permission_set.include?( MerchantPermission.find_by(id: 27) )
		end

		def show?
			@permission_set.include?( MerchantPermission.find_by(id: 36) )
		end

		def edit?
			false
		end

		def delete?
			false
		end

	end
end