class SendMessage < MessagesPermissionLogic
  def check
    return true if @permission_set.include?( MerchantPermission.find_by(id: 27) )
  end
end