class ResourceRequestsController < ApplicationController
  require 'sendgrid-ruby'
  include SendGrid
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!
  
  def create 
  	binding.pry
  	email = params[:resource_request][:email]

  	UserEmailer.send_book_resources(email).deliver_now

  	redirect_to "/"
  	
  	# UserEmailer.with(email: email).send_book_resources.deliver_now

  	# redirect_to url_for(:controller => :user_emailer, :action => :send_book_resources, :email => email)
  end

end