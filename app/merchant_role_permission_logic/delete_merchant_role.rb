class DeleteMerchantRole < MerchantRolePermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 25) )
  end
end