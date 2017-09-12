module Permissions
	class CompanyUser < Permissions::Base

		def create?
			@permission_set.include?( CompanyPermission.find_by(id: 1) )
		end

		def show?
			@permission_set.include?( CompanyPermission.find_by(id: 2) )
		end

		def edit?
			@permission_set.include?( CompanyPermission.find_by(id: 3) )
		end

		def delete?
			@permission_set.include?( CompanyPermission.find_by(id: 4) )
		end

	end
end