class EditCustomer < CustomerPermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 34) )
  end
end