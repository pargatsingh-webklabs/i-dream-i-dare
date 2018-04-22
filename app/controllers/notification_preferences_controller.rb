class NotificationPreferencesController < ApplicationController
  before_action :set_notification_preference, only: [:show, :edit, :update, :destroy]

  # GET /notification_preferences
  def index
    @notification_preferences = NotificationPreference.all
  end

  # GET /notification_preferences/1
  def show
  end

  # GET /notification_preferences/new
  def new
    @notification_preference = NotificationPreference.new
  end

  # GET /notification_preferences/1/edit
  def edit
  end

  # POST /notification_preferences
  def create
    @notification_preference = NotificationPreference.new(notification_preference_params)

    if @notification_preference.save
      redirect_to @notification_preference, notice: 'Notification preference was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /notification_preferences/1
  def update
    if @notification_preference.update(notification_preference_params)
      redirect_to @notification_preference, notice: 'Notification preference was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /notification_preferences/1
  def destroy
    @notification_preference.destroy
    redirect_to notification_preferences_url, notice: 'Notification preference was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification_preference
      @notification_preference = NotificationPreference.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def notification_preference_params
      params.require(:notification_preference).permit(:notification_reason, :notification_type, :user_id)
    end
end
