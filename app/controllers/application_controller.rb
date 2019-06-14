class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # def confirm_logged_in
  #   unless session[:user_id]
  #     flash[:notice] = "You must be logged in to do that"
  #     redirect_to "root_path"
  #     return false
  #   else
  #     return true
  #   end
  # end

end
