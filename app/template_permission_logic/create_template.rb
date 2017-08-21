class CreateTemplate < TemplatePermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 37) )
  end
end