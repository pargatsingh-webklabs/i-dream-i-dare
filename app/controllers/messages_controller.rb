class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  before_filter :authorized_user_or_admin, only: [:show, :edit, :update]
  before_filter :admin_user, only: [:index, :destroy]
  layout "signed-in" # Layout Default

  # GET /messages
  def index
    @messages = Message.all
    render layout: "signed-in"
  end

  # GET /messages/1
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  def create
    @message = Message.new(message_params)

    if @message.save

      id = @message.id
        alerts = AlertsController.new
        alerts.request = request
        alerts.response = response
        alerts.send_notifications("msg_received", id)
      redirect_to "/user/dashboard/#{@message.to}", notice: 'Message was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      redirect_to "/user/dashboard/#{@message.to}", notice: 'Message was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
    redirect_to "/user/dashboard/#{@message.to}", notice: 'Message was successfully destroyed.'
  end

  private

    def authorized_user_or_admin
      redirect_to "/422" unless @message.to == current_user.id || @message.from == current_user.id || current_user.is_an_admin?
    end
    
    def admin_user
      redirect_to "/422" unless current_user.is_an_admin?
    end


    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:from, :to, :content)
    end
end
