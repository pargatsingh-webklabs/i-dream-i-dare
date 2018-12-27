class UserEmailer < ApplicationMailer
  # default :from => 'any_from_address@example.com'

  def send_book_resources(email)
  	mail( :to => email,
    :subject => 'Your requested resources from I Dream I Dare' )
  end

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end
end
