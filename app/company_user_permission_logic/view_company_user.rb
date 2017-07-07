class ViewCompanyUser < CompanyUserPermissionLogic
  def check
    return true if @permission_set.include?( CompanyPermission.find_by(id: 2) )
  end
end