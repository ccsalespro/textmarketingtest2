class CreateMerchantRole < MerchantRolePermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 22) )
  end
end