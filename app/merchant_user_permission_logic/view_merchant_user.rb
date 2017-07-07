class ViewMerchantUser < MerchantUserPermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 19) )
  end
end