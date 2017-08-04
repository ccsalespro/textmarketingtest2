class CreateMerchantBillingPlan < MerchantBillingPlanPermissionLogic
  def check
    return true if @permission_set.include?( CompanyPermission.find_by(id: 28) )
  end
end