class CreateCompanyRole < CompanyRolePermissionLogic
  def check
    return true if @permission_set.include?( CompanyPermission.find_by(id: 5) )
  end
end