class CreateCompanyRole < CompanyRolePermissionLogic
  def evaluate
    if @permission_set.include?( CompanyPermission.find_by(id: 5) )
       return true
   	else
   		redirect_to root_path
      return false
 		end
  end
end