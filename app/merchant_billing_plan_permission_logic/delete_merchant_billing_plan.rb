class DeleteMerchantBillingPlan < MerchantBillingPlanPermissionLogic
  def check
    return true if @permission_set.include?( CompanyPermission.find_by(id: 31) )
  end
end