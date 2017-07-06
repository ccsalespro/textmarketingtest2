class CreateCompanyRole < CompanyRolePermissionLogic
  def evaluate
    if @permission_set.include?( CompanyPermission.find_by(name: "Create Company Roles") )
       return true
   	else
   		redirect_to root_path
      return false
 		end
  end
end