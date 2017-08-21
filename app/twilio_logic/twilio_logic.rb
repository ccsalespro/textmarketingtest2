require 'twilio-ruby'

class TwilioLogic

  def send_outgoing_message(merchant, message)
    if check_if_message_sent_in_last_hour(merchant)
      boot_twilio()
      merchant.customers.all.each do |customer|
        if customer.permission_to_text == true
          sms = @client.messages.create(
            from: merchant.phone_number,
            to: customer.phone_number,
            body: message.body
          )
        end
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
    @twilio_number = params["To"]

    save_message_body(request, @message_body)

    @merchant_user = MerchantUser.find_by(phone_number: @from_number)

    if @merchant_user.present?

      @role = MerchantRole.find_by(id: @merchant_user.merchant_role_id)
      @merchant = Merchant.find_by(id: @role.merchant_id)

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
      if @message_body.upcase == "START" || @message_body.upcase == "SUBSCRIBE" || @message_body.upcase == "UNSTOP"
        send_successful_subscribed_message(@from_number, @twilio_number)
      elsif @message_body.upcase == "STOP" || @message_body.upcase == "UNSUBSCRIBE"
        send_successful_unsubscribed_message(@from_number, @twilio_number)
      else
        send_fail_response()
      end
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

  def send_permission_to_text_request(customer)
    boot_twilio()
    sms = @client.messages.create(
        from: customer.merchant.phone_number,
        to: customer.phone_number,
        body: "Text START to receive special deals delivered right to your phone by #{customer.merchant.name}!\nReply STOP at any time to stop, HELP to help. Msg & Data Rates apply."
      )
  end

  def send_successful_subscribed_message(number, twilio_number)
    @merchant = Merchant.find_by(phone_number: twilio_number)
    if @merchant.customers.include?(Customer.find_by(merchant_id: @merchant.id, phone_number: number))
      @customer = Customer.find_by(merchant_id: @merchant.id, phone_number: number)
      @customer.permission_to_text = true
      @customer.save
    else
      @customer = @merchant.customers.build
      @customer.phone_number = number
      @customer.permission_to_text = true
      @customer.save
    end
  end

  def send_successful_unsubscribed_message(number, twilio_number)
    @merchant = Merchant.find_by(phone_number: twilio_number)
    if @merchant.customers.include?(Customer.find_by(merchant_id: @merchant.id, phone_number: number))
      @customer = Customer.find_by(merchant_id: @merchant.id, phone_number: number)
      @customer.destroy
    else
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
        body: "Please text START to subscribe to this number or STOP to unsubscribe."
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
      if @customer.permission_to_text == true
        sms = @client.messages.create(
          from: @merchant.phone_number,
          to: customer.phone_number,
          body: request.session[:message_body] + "\nReply STOP to stop"
        )
      end
    end
    save_message_to_database(@merchant)
    UpdateMessageCount.new.run(@merchant)
  end

  def save_message_to_database(merchant)
    @message = Message.new
    @message.body = request.session[:message_body]
    @message.merchant_id = merchant.id
    @message.save
  end

end