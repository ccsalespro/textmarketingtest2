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

    # Get incoming message info
    @message_body = params["Body"]
    @from_number = params["From"]

    save_message_body(request, @message_body)

    # Check MerchantUser Permissions
    @merchant_user = MerchantUser.find_by(phone_number: @from_number)
    if @merchant_user.present?
      @role = MerchantRole.find_by(id: @merchant_user.merchant_role_id)
      if @role.merchant_permissions.include?( MerchantPermission.find_by(id: 27) )
        send_response(request, @role)
      else
        send_insufficient_permissions_response()
      end
    else
      send_fail_response()
    end

  end


  def send_response(request, user_role)
    set_session_variable(request)
    boot_twilio()

    if request.session[:confirmation_sent] == false
      send_confirmation()
      request.session[:confirmation_sent] = true
    else
      if @message_body.downcase == "yes"
        send_out_message(request, user_role)
        send_success_response(request)
        request.session[:message_body] = ""
      else
        send_cancel_response()
        request.session[:message_body] = ""
      end
      request.session[:confirmation_sent] = false
    end
  end


  def send_confirmation
    sms = @client.messages.create(
        from: Rails.application.secrets.twilio_number,
        to: @from_number,
        body: "You Are About To Send Out The Following Message: \n #{@message_body} \n Respond 'yes' To Send It."
      )
  end

  def send_success_response(request)
    sms = @client.messages.create(
        from: Rails.application.secrets.twilio_number,
        to: @from_number,
        body: "You Sent Out The Following Message: \n #{request.session[:message_body]}"
      )

  end

  def send_cancel_response
    sms = @client.messages.create(
        from: Rails.application.secrets.twilio_number,
        to: @from_number,
        body: "Message Canceled"
      )
  end

  def send_fail_response
    sms = @client.messages.create(
        from: Rails.application.secrets.twilio_number,
        to: @from_number,
        body: "Phone Number Not Recognized"
      )
  end
 
  def boot_twilio
    account_sid = ENV["TWILIO_SID"]
    auth_token = ENV["TWILIO_TOKEN"]
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def set_session_variable(request)
    if request.session[:confirmation_sent] != true
      request.session[:confirmation_sent] = false
    end
    return request.session[:confirmation_sent]
  end

  def save_message_body(request, message_body)
    if request.session[:message_body] == ""
      request.session[:message_body] = message_body
    end
    return request.session[:message_body]
  end

  def send_insufficient_permissions_response
    sms = @client.messages.create(
        from: Rails.application.secrets.twilio_number,
        to: @from_number,
        body: "Insufficient Permissions"
      )
  end

  def send_out_message(user_role, request)
    @merchant = Merchant.find_by(id: user_role.merchant_id)
    @merchant.customers.each do |customer|
      sms = @client.messages.create(
        from: @merchant.phone_number,
        to: customer.phone_number,
        body: request.session[:message_body]
      )
    end
  end

end