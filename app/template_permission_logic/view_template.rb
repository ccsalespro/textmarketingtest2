class ViewTemplate < TemplatePermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 38) )
  end
end