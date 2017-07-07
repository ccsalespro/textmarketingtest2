class CreateMerchant < MerchantPermissionLogic
  def check
    return true if @permission_set.include?( CompanyPermission.find_by(id: 9) )
  end
end