class EditMerchant < MerchantPermissionLogic
  def check
    return true if @permission_set.include?( CompanyPermission.find_by(id: 11) )
  end
end