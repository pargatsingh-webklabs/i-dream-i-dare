class AlertsController < ApplicationController
  require 'sendgrid-ruby'
  include SendGrid
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!  #, :only => "reply"
 
 # This comes from the event that triggers a notification.
  def send_notifications(event, createdModelId)
    user = current_user.id

    if event == "plan_created"
      plan = Plan.find_by_id(createdModelId)

      user_notifications_sms = NotificationPreference.where(notification_reason: "plan_created", notification_type: "sms")
      user_notifications_email = NotificationPreference.where(notification_reason: "plan_created", notification_type: "email")

      if user_notifications_sms.empty? == false # This needs to pick up the numbers that want the sms, and the name of the User for whom the plan was created.
        user_notifications_sms.each do |note|
          user = User.find(note.user_id)
          binding.pry
          body = "A Plan was created for " + user.first_name + " " + user.last_name + ". Here are the details: " + plan.title + plan.content
          to = user.sms_phone_number
          send_SMS(body, to)
        end
      end

      if user_notifications_email.empty? == false # This needs to iterate through the records.
        body = "A Plan was created for you!" 
        to = "4022133739"
        send_email(body, to)
      end

    end
    if event == "msg_received"
      msg = Message.find_by_id(createdModelId)

    end
    if event == "grp_msg_received"
      grpMsg = GroupMessage.find_by_id(createdModelId)

    end

    # TODO - Create Plan Reminder Model
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

  def send_email(body, to)
    # Need to create this
  end

  # ALL TRAFFIC FROM TWILIO HITS HERE FIRST
  def reply_SMS
    message_body = params["Body"]
    from_number = params["From"]
    boot_twilio
    sms = @client.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: from_number,
      body: "Hello, this is a test of the Dreamcatcher alert system. Your number is #{from_number}. Please text (531) 201-8196 to re-test this application's reply."
    )
  end

  # TODO - Update this to use SMTP system instead (REPLACE).
  # def send_email
  #   from = Email.new(email: 'idreamidare@gmail.com')
  #   to = Email.new(email: 'jeremys@volanosolutions.com')
  #   subject = 'SendGrid is Fun-ish'
  #   content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby..?')
  #   mail = Mail.new(from, subject, to, content)

  #   sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  #   response = sg.client.mail._('send').post(request_body: mail.to_json)
  #   puts response.status_code
  #   puts response.body
  #   puts response.headers
  # end

  private
 
  def boot_twilio
    account_sid = ENV['TWILIO_SID'] 
    auth_token = ENV['TWILIO_TOKEN'] 
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

# def reply

#   @client = Twilio::REST::Client.new account_sid, auth_token
#   message = @client.account.messages.create(:body => "Hello from Ruby",
#       :to => "+14022133739",    # Replace with your phone number
#       :from => "+14027692709")  # Replace with your Twilio number

#   puts message.sid
# end


end