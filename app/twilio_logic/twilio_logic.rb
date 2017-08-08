require 'twilio-ruby'

class TwilioLogic

  def send_outgoing_message(merchant, message)
    if check_if_message_sent_in_last_hour(merchant)
      boot_twilio()
      merchant.customers.all.each do |customer|
        sms = @client.messages.create(
          from: merchant.phone_number,
          to: customer.phone_number,
          body: message.body
        )
      end
    else
      redirect_to :root_path, notice: "You Already Sent Out A Message In The Past Hour"
    end
  end

	def reply(params, request)
    boot_twilio()
    # Get incoming message info
    @message_body = params["Body"]
    @from_number = params["From"]

    save_message_body(request, @message_body)

    @merchant_user = MerchantUser.find_by(phone_number: @from_number)
    @role = MerchantRole.find_by(id: @merchant_user.merchant_role_id)
    @merchant = Merchant.find_by(id: @role.merchant_id)

    if @merchant_user.present?
      #@role = MerchantRole.find_by(id: @merchant_user.merchant_role_id)
      if @role.merchant_permissions.include?( MerchantPermission.find_by(id: 27) )
        if request.session[:confirmation_sent] == false
            send_response(request, @role)
        else
          send_response(request, @role)
          set_timeout(@merchant)
        end
      else
        send_insufficient_permissions_response(@role)
      end
    else
      send_fail_response()
    end

  end


  def send_response(request, user_role)
    set_session_variable(request)
    boot_twilio()

    if request.session[:confirmation_sent] == false
      send_confirmation(user_role)
      request.session[:confirmation_sent] = true
    else
      if @message_body.downcase == "yes"
        send_out_message(request, user_role)
        send_success_response(request, user_role)
        request.session[:message_body] = ""
      else
        send_cancel_response(user_role)
        request.session[:message_body] = ""
      end
      request.session[:confirmation_sent] = false
    end
  end

  def check_if_message_sent_in_last_hour(merchant)
    if merchant.timeout_end > Time.now.to_s
      return true
    else
      return false
    end
  end

  def send_too_many_messages_error(user_role)
    boot_twilio()
    @merchant = Merchant.find_by(id: user_role.merchant_id)
    sms = @client.messages.create(
        from: @merchant.phone_number,
        to: @from_number,
        body: "You Already Sent Out A Message In The Past Hour"
      )
  end

  def set_timeout(merchant)
    merchant.timeout_end = 1.hour.from_now
    merchant.save
  end


  def send_confirmation(user_role)
    @merchant = Merchant.find_by(id: user_role.merchant_id)
    sms = @client.messages.create(
        from: @merchant.phone_number,
        to: @from_number,
        body: "You Are About To Send Out The Following Message: \n #{@message_body} \n Respond 'yes' To Send It."
      )
  end

  def send_success_response(request, user_role)
    @merchant = Merchant.find_by(id: user_role.merchant_id)
    sms = @client.messages.create(
        from: @merchant.phone_number,
        to: @from_number,
        body: "You Sent Out The Following Message: \n #{request.session[:message_body]}"
      )

  end

  def send_cancel_response(user_role)
    @merchant = Merchant.find_by(id: user_role.merchant_id)
    sms = @client.messages.create(
        from: @merchant.phone_number,
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

  def send_insufficient_permissions_response(user_role)
    @merchant = Merchant.find_by(id: user_role.merchant_id)
    sms = @client.messages.create(
        from: @merchant.phone_number,
        to: @from_number,
        body: "Insufficient Permissions"
      )
  end

  def send_out_message(request, user_role)
    @merchant = Merchant.find_by(id: user_role.merchant_id)
    @merchant.customers.each do |customer|
      sms = @client.messages.create(
        from: @merchant.phone_number,
        to: customer.phone_number,
        body: request.session[:message_body]
      )
    end
    save_message_to_database(@merchant)
  end

  def save_message_to_database(merchant)
    @message = Message.new
    @message.body = request.session[:message_body]
    @message.merchant_id = merchant.id
    @message.save
  end

end