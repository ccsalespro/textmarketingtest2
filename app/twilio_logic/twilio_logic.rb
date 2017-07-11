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

	def reply(params, request)

    @message_body = params["Body"]
    @from_number = params["From"]

    if session[:confirmation_sent] != true
      session[:confirmation_sent] = false
    end
    boot_twilio()

    if session[:confirmation_sent] == false
      send_confirmation()
      session[:confirmation_sent] = true
    else
      if @message_body.downcase == "yes"
        send_success_response()
      else
        send_cancel_response()
      end
      session[:confirmation_sent] = false
    end
  end

  private

  def send_confirmation
    sms = @client.messages.create(
        from: Rails.application.secrets.twilio_number,
        to: @from_number,
        body: "You Are About To Send Out The Following Message: \n #{@message_body} \n Respond 'yes' To Send It."
      )
  end

  def send_success_response
    sms = @client.messages.create(
        from: Rails.application.secrets.twilio_number,
        to: @from_number,
        body: "You Sent Out The Following Message: \n #{@message_body}"
      )
  end

  def send_cancel_response
    sms = @client.messages.create(
        from: Rails.application.secrets.twilio_number,
        to: @from_number,
        body: "You Canceled Sending Out The Following Message: \n #{@message_body}"
      )
  end
 
  def boot_twilio
    account_sid = ENV["TWILIO_SID"]
    auth_token = ENV["TWILIO_TOKEN"]
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

end