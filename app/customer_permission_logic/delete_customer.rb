class DeleteCustomer < CustomerPermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 35) )
  end
end