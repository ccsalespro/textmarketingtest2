class ViewCompanyRole < CompanyRolePermissionLogic
  def check
    return true if @permission_set.include?( CompanyPermission.find_by(id: 6) )
  end
end