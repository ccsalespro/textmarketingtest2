class EditMerchantBillingPlan < MerchantBillingPlanPermissionLogic
  def check
    return true if @permission_set.include?( CompanyPermission.find_by(id: 30) )
  end
end