class EditMerchantUser < MerchantUserPermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 20) )
  end
end