class AlertsController < ApplicationController
  skip_before_filter :verify_authenticity_token
 skip_before_filter :authenticate_user!, :only => "reply"
 
  def reply
  	debugger;
    message_body = params["Body"]
    from_number = params["From"]
    debugger;
    boot_twilio
     debugger;
    sms = @client.messages.create(
      from: Rails.application.config.secrets.twilio_number,
      to: from_number,
      body: "Hello, this is the Dreamcatcher alert system. Your number is #{from_number}."
    )
    
  end
 
  private
 
  def boot_twilio
  	 debugger;
    account_sid = Rails.application.config.secrets.twilio_sid
    auth_token = Rails.application.config.secrets.twilio_token
    @client = Twilio::REST::Client.new account_sid, auth_token
  end
end