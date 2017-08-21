class EditTemplate < TemplatePermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 39) )
  end
end