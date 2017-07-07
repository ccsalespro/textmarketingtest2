class EditCompanyUser < CompanyUserPermissionLogic
  def check
    return true if @permission_set.include?( CompanyPermission.find_by(id: 3) )
  end
end