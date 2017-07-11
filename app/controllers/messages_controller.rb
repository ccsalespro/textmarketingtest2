class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

	before_action :set_message, only: [:show]
  before_action :set_merchant

	def index
		@messages = @merchant.messages.all
	end

  def show
  end

  def new
    @message = @merchant.messages.build
  end

  def reply
    TwilioLogic.new.reply(params, request)
  end

  def create
    @message = @merchant.messages.build(message_params)
    TwilioLogic.new.send_message(@merchant, @message)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_merchant
      @merchant = Merchant.find_by_subdomain(request.subdomain)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:subject, :body, :email, :merchant_id)
    end
end
