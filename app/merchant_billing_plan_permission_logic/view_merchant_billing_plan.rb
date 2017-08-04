class ViewMerchantBillingPlan < MerchantBillingPlanPermissionLogic
  def check
    return true if @permission_set.include?( CompanyPermission.find_by(id: 29) )
  end
end