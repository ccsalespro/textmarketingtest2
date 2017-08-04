class CreateCustomer < CustomerPermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 32) )
  end
end