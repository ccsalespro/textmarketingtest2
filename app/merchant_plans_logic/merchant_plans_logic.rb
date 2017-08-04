class MerchantPlansLogic

	def check_merchants_merchant_plans(merchant, merchant_billing_plan, merchant_billing_plan_id)
		collect_merchant_billing_plans_ids(merchant.merchant_billing_plans)
		if @merchant_billing_plans_ids.include?(merchant_billing_plan_id.to_i )
			raise
			return false
		elsif MerchantBillingPlan.find_by_id(merchant_billing_plan_id.to_i).service_type.name != "SMS"
			return true
		end
	end

	def collect_merchant_billing_plans_ids(merchant_billing_plans)
		@merchant_billing_plans_ids = []
		merchant_billing_plans.each do |mbp|
			@merchant_billing_plans_ids << mbp.id
		end
		return @merchant_billing_plans_ids
	end

end