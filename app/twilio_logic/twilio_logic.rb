require 'twilio-ruby'

class TwilioLogic

  def send_message(merchant, message)
    boot_twilio
    merchant.customers.all.each do |customer|
      sms = @client.messages.create(
        from: Rails.application.secrets.twilio_number,
        to: customer.phone_number,
        body: message.body
      )
    end
  end

	def reply
    boot_twilio
    #message_body = params["Body"]
    from_number = params["From"]
    sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: from_number,
      body: "Hello there, thanks for texting me. Your number is #{from_number}."
    )
    
  end
 
  def boot_twilio
    account_sid = ENV["TWILIO_SID"]
    auth_token = ENV["TWILIO_TOKEN"]
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

end