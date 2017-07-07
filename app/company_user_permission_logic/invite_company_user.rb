class InviteCompanyUser < CompanyUserPermissionLogic
  def check
    return true if @permission_set.include?( CompanyPermission.find_by(id: 1) )
  end
end