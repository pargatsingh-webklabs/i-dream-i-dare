class ApplicationMailer < ActionMailer::Base
  add_template_helper(UserEmailerHelper)
  
  default from: "i.dream.i.dare@gmail.com"
  layout "mailer"
end
