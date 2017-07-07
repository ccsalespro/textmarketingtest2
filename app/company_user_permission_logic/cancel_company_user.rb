class CancelCompanyUser < CompanyUserPermissionLogic
  def check
    return true if @permission_set.include?( CompanyPermission.find_by(id: 4) )
  end
end