class EditMerchantRole < MerchantRolePermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 24) )
  end
end