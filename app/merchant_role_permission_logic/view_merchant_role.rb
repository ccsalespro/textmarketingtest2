class ViewMerchantRole < MerchantRolePermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 23) )
  end
end