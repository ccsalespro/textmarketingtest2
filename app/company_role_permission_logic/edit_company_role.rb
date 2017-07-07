class EditCompanyRole < CompanyRolePermissionLogic
  def check
    return true if @permission_set.include?( CompanyPermission.find_by(id: 7) )
  end
end