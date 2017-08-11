class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

	before_action :set_message, only: [:show]

	def index
    redirect_to root_path unless ViewMessage.new(current_merchant_user, current_admin).check
		@messages = @merchant.messages.all
	end

  def show
    redirect_to root_path unless ViewMessage.new(current_merchant_user, current_admin).check
  end

  def new
    redirect_to root_path unless SendMessage.new(current_merchant_user, current_admin).check
    @message = @merchant.messages.build
    if params[:template].present?
      @template = Template.find_by(id: params[:template].to_i)
      @message.subject = @template.subject
      @message.body = @template.body
    end
  end

  def reply
    TwilioLogic.new.reply(params, request)
  end

  def create
    redirect_to root_path unless SendMessage.new(current_merchant_user, current_admin).check
    @message = @merchant.messages.build(message_params)
    TwilioLogic.new.send_outgoing_message(@merchant, @message)

    respond_to do |format|
      if @message.save
        UpdateMessageCount.new.run(@merchant)
        format.html { redirect_to @message, notice: 'message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:subject, :body, :email, :merchant_id)
    end
end
