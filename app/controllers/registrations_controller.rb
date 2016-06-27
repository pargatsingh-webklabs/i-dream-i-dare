# This file is an extension to Devise's auth, to include our custom "first_name", "last_name", is_a_coach" and "is_an_admin" columns for the User model. Also, see config/routes.rb for additional modifications.
#Reference:
#http://jacopretorius.net/2014/03/adding-custom-fields-to-your-devise-user-model-in-rails-4.html 

class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :is_a_coach, :is_an_admin, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :is_a_coach, :is_an_admin, :email, :password, :password_confirmation, :current_password)
  end
end