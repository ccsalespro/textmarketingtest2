module Permissions
	class Company < Permissions::Base

		def create?
			false
		end

		def show?
			@permission_set.include?( CompanyPermission.find_by(id: 17) )
		end

		def edit?
			false
		end

		def delete?
			false
		end

	end
end