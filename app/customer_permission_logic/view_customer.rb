class ViewCustomer < CustomerPermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 33) )
  end
end