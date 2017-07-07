class ViewCompany < CompanyPermissionLogic
  def check
    return true if @permission_set.include?( CompanyPermission.find_by(id: 17) )
  end
end