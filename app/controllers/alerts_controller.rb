class AlertsController < ApplicationController
  require 'sendgrid-ruby'
  include SendGrid
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!

  def send_email(body, to)
    # Need to create this- see the User_Emailer controller
    binding.pry
  end

 # This comes from the event that triggers a notification (eg: Plan Created, Msg Sent, Grp Msg Sent, etc).
  def send_notifications(event, createdModelId)
    
    if event == "plan_created"
      plan = Plan.find_by_id(createdModelId)

      user_notifications_sms = NotificationPreference.where(notification_reason: "plan_created", notification_type: "sms", user_id: plan.client)
      user_notifications_email = NotificationPreference.where(notification_reason: "plan_created", notification_type: "email", user_id: plan.client)

      if user_notifications_sms.empty? == false
        user_notifications_sms.each do |note|
          user = User.find(note.user_id)
          body = "A Plan was created for " + user.first_name + " " + user.last_name + ". Title: " + plan.title + ". Go to the I Dream I Dare website to see your new plan."
          to = user.sms_phone_number
          send_SMS(body, to)
        end
      end

      if user_notifications_email.empty? == false
        user_notifications_email.each do |note|
          user = User.find(note.user_id)
          body = "A Plan was created for " + user.first_name + " " + user.last_name + ". Title: " + plan.title + ". Go to the I Dream I Dare website to see your new plan."
          to = user.email
          send_email(body, to)
        end
      end

    end

    if event == "msg_received"
      msg = Message.find_by_id(createdModelId)
      fromUser = User.find(msg.from)
      toUser = User.find(msg.to)
      user_notifications_sms = NotificationPreference.where(notification_reason: "msg_received", notification_type: "sms", user_id: msg.to)
      user_notifications_email = NotificationPreference.where(notification_reason: "msg_received", notification_type: "email", user_id: msg.to)

      if user_notifications_sms.empty? == false
        user_notifications_sms.each do |note|
          user = User.find(note.user_id)
          body = "A Message was sent to " + toUser.first_name + " " + toUser.last_name + " from " + fromUser.first_name + " " + fromUser.last_name + ". Content: " + msg.content
          to = user.sms_phone_number
          send_SMS(body, to)
        end
      end

      if user_notifications_email.empty? == false
        user_notifications_email.each do |note|
          user = User.find(note.user_id)
          body = "A Message was sent to " + toUser.first_name + " " + toUser.last_name + " from " + fromUser.first_name + " " + fromUser.last_name + ". Content: " + msg.content
          to = user.email
          send_email(body, to)
        end
      end
    end

    if event == "grp_msg_received"
      grpMsg = GroupMessage.find_by_id(createdModelId)
    end

    if event == "plan_reminder"
      # planRem = PlanReminder.find_by_id(createdModelId)
    end

  end

  def create_alert
    my_alert = Alert.new
    my_alert.alert_title = params["Title"]
    my_alert.alert_body = params["Body"]
    my_alert.alert_type = params["Type"]
    my_alert.alert_to = params["To"] # This is a user_id, to be looked up in Users for the phone number to send the sms.
    my_alert.scheduled_alert = params["Schedule"]
    my_alert.save
  # Separate these into two actions, after testing. This immediately sends out all alerts, but we need to be looking at the scheduled_alert field.
    alert_user = User.find(my_alert.alert_to)
    sms_to = alert_user.sms_phone_number
    boot_twilio
    sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: sms_to,
      body: my_alert.alert_body)
  end

  def send_SMS(body, to)
    boot_twilio
    sms = @client.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: to,
      body: body
    )
  end

  # ALL TRAFFIC FROM TWILIO (Text or Voice call) HITS HERE FIRST.
  def reply_SMS
    message_body = params["Body"]
    from_number = params["From"]
    body = "Hello, this is a test of the Dreamcatcher alert system. Your number is #{from_number}. Please text (531) 201-8196 to re-test this application's reply."
    if message_body.downcase.include?("stop")
      # Do Something, change records, save stuff.
      user = User.where(sms_phone_number: from_number)
      user.sms_phone_number = ''
      user.save
    end
    boot_twilio
    sms = @client.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: from_number,
      body: body
    )
  end

  private
 
  def boot_twilio
    account_sid = ENV['TWILIO_SID'] 
    auth_token = ENV['TWILIO_TOKEN'] 
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

end