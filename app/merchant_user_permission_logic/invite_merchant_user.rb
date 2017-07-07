class InviteMerchantUser < MerchantUserPermissionLogic
  def check
    if @user.present?
    	return true if @permission_set.include?( MerchantPermission.find_by(id: 18) )
    elsif @company_user.present?
    	return true if @permission_set.include?( CompanyPermission.find_by(id: 13) )
    else
    	return true if @permission_set.include?( MerchantPermission.find_by(id: 18) )
    end
  end
end