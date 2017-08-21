class DeleteTemplate < TemplatePermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 40) )
  end
end