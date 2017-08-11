class UpdateMessageCount
	def run(merchant)
		merchant.customers.each do |customer|
			customer_message = customer.customer_messages.build
			customer_message.message_id = merchant.id
			customer_message.save
		end
	end
end