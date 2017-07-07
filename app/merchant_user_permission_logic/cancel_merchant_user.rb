class CancelMerchantUser < MerchantUserPermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 21) )
  end
end