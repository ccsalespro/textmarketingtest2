class ViewMessage < MessagesPermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 36) )
  end
end