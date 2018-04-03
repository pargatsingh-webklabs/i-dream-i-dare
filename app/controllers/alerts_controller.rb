class AlertsController < ApplicationController
  skip_before_filter :verify_authenticity_token
 skip_before_filter :authenticate_user!  #, :only => "reply"
 
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

  # For testing the Alert System
  def reply
    message_body = params["Body"]
    from_number = params["From"]
    boot_twilio
    sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: from_number,
      body: "Hello, this is a test of the Dreamcatcher alert system. Your number is #{from_number}. Please text (531) 201-8196 to re-test this application's reply."
    )
    
  end

  private
 
  def boot_twilio
    account_sid = Rails.application.secrets.twilio_sid 
    auth_token = Rails.application.secrets.twilio_token 
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