class ViewMerchant < MerchantPermissionLogic
  def check
  	if @user.present?
    	return true if @permission_set.include?( CompanyPermission.find_by(id: 10) )
    elsif @merchant.present?
    	return true if @permission_set.include?( MerchantPermission.find_by(id: 26) )
    else
    	return true if @permission_set.include?( CompanyPermission.find_by(id: 10) )
    end
  end
end