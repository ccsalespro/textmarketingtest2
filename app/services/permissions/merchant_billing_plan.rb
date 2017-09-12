module Permissions
	class MerchantBillingPlan < Permissions::Base

		def create?
			@permission_set.include?( CompanyPermission.find_by(id: 28) )
		end

		def show?
			@permission_set.include?( CompanyPermission.find_by(id: 29) )
		end

		def edit?
			@permission_set.include?( CompanyPermission.find_by(id: 30) )
		end

		def delete?
			@permission_set.include?( CompanyPermission.find_by(id: 31) )
		end

	end
end