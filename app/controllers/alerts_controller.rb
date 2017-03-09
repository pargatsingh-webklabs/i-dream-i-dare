class AlertsController < ApplicationController
  skip_before_filter :verify_authenticity_token
 skip_before_filter :authenticate_user!, :only => "reply"
 
  def create_alert
    my_alert = Alert.new
    my_alert.alert_title = params["Title"]
    my_alert.alert_body = params["Body"]
    my_alert.alert_type = params["Type"]
    my_alert.alert_to = params["To"]
    my_alert.scheduled_alert = params["Schedule"]
    my_alert.save
    send_sms_alert(params[:my_alert])
  end

  def send_sms_alert
    sms_alert = params[:my_alert]
    debugger;
    boot_twilio
    sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: from_number,
      body: "Hello, this is a test of the Dreamcatcher alert system. Please text (402)769-2709 to re-test this application's reply."
  end

  # For testing the Alert System
  def reply
    message_body = params["Body"]
    from_number = params["From"]
    boot_twilio
    sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: from_number,
      body: "Hello, this is a test of the Dreamcatcher alert system. Your number is #{from_number}. Please text (402)769-2709 to re-test this application's reply."
    )
    
  end

  private
 
  def boot_twilio
    account_sid = Rails.application.secrets.twilio_sid 
    auth_token = Rails.application.secrets.twilio_token 
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

# def reply

#   account_sid = "AC7f31bedb178e5c29681712d702181f29" # Your Account SID from www.twilio.com/console
#   auth_token = "0b67f2ae87cae02e784c98378a806368"   # Your Auth Token from www.twilio.com/console

#   @client = Twilio::REST::Client.new account_sid, auth_token
#   message = @client.account.messages.create(:body => "Hello from Ruby",
#       :to => "+14022133739",    # Replace with your phone number
#       :from => "+14027692709")  # Replace with your Twilio number

#   puts message.sid
# end


end