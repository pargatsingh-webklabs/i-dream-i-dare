class GroupMessagesController < ApplicationController
  before_action :set_group_message, only: [:show, :edit, :update, :destroy]

  # GET /group_messages
  def index
    @group_messages = GroupMessage.all
  end

  # GET /group_messages/1
  def show
  end

  # GET /group_messages/new
  def new
    @group_message = GroupMessage.new
  end

  # GET /group_messages/1/edit
  def edit
  end

  # POST /group_messages
  def create
    @group_message = GroupMessage.new(group_message_params)

    if @group_message.save
      redirect_to "/user/group-dashboard/#{@group_message.group_id}", notice: 'Group message was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /group_messages/1
  def update
    if @group_message.update(group_message_params)
      redirect_to "/user/group-dashboard/#{@group_message.group_id}", notice: 'Group message was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /group_messages/1
  def destroy
    @group_message.destroy
    redirect_to "/group/dashboard/#{@group_message.group_id}", notice: 'Group message was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_message
      @group_message = GroupMessage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def group_message_params
      params.require(:group_message).permit(:group_id, :from, :content)
    end
end
