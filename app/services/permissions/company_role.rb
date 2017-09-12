module Permissions
	class CompanyRole < Permissions::Base

		def create?
			@permission_set.include?( CompanyPermission.find_by(id: 5) )
		end

		def show?
			@permission_set.include?( CompanyPermission.find_by(id: 6) )
		end

		def edit?
			@permission_set.include?( CompanyPermission.find_by(id: 7) )
		end

		def delete?
			@permission_set.include?( CompanyPermission.find_by(id: 8) )
		end

	end
end