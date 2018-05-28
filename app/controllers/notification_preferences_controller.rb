class NotificationPreferencesController < ApplicationController
  layout "signed-in"

  # GET /notification_preferences
  def index
    notification_preferences = NotificationPreference.select{|p| p.user_id == current_user.id}
    @plan_created_notifications_sms = notification_preferences.select{|p| p.notification_reason == 'plan_created' && p.notification_type == 'sms'}
    @msg_received_notifications_sms = notification_preferences.select{|p| p.notification_reason == 'msg_received' && p.notification_type == 'sms'}
    @grp_msg_received_notifications_sms = notification_preferences.select{|p| p.notification_reason == 'grp_msg_received' && p.notification_type == 'sms'}
    @plan_created_notifications_email = notification_preferences.select{|p| p.notification_reason == 'plan_created' && p.notification_type == 'email'}
    @msg_received_notifications_email = notification_preferences.select{|p| p.notification_reason == 'msg_received' && p.notification_type == 'email'}
    @grp_msg_received_notifications_email = notification_preferences.select{|p| p.notification_reason == 'grp_msg_received' && p.notification_type == 'email'}
    @plan_reminders_sms = notification_preferences.select{|p| p.notification_reason == 'plan_reminder' && p.notification_type == 'sms'}
    @plan_reminders_email = notification_preferences.select{|p| p.notification_reason == 'plan_reminder' && p.notification_type == 'email'}
    @helpful_reminders_sms = notification_preferences.select{|p| p.notification_reason == 'helpful_reminder' && p.notification_type == 'sms'}
    @helpful_reminders_email = notification_preferences.select{|p| p.notification_reason == 'helpful_reminder' && p.notification_type == 'email'}
    @notification_preference = NotificationPreference.new
  end

  def enable_notification
    reason = params[:reason]
    type = params[:type]
    make = NotificationPreference.new
    make.user_id = current_user.id
    make.notification_reason = reason
    make.notification_type = type
    make.save
    redirect_to notification_preferences_url #, notice: 'Notification preference was successfully updated.'
  end

  def disable_notification
    reason = params[:reason]
    type = params[:type]
    kill = NotificationPreference.where("user_id = ? AND notification_reason = ? AND notification_type = ?", current_user.id, reason, type)
    NotificationPreference.destroy(kill)
    redirect_to notification_preferences_url #, notice: 'Notification preference was successfully updated.'
  end

    def notification_preference_params
      params.require(:notification_preference).permit(:notification_reason, :notification_type, :user_id)
    end
end
