# This file is an extension to the Devise gem's auth, to include our custom "first_name", "last_name", is_a_coach" and "is_an_admin" columns for the User model. Also, see config/routes.rb for additional modifications.
#Reference:
#http://jacopretorius.net/2014/03/adding-custom-fields-to-your-devise-user-model-in-rails-4.html 

class RegistrationsController < Devise::RegistrationsController

  # The following line prevents new sign-ups for everyone. 
  # TODO: Make a pop-up alert that accepts a password to sign up for a user account.
  # For now, there are open sign-ups.

  # ////////////////////////////////////////Uncomment this if you want to close all sign-ups.

  # prepend_before_filter :authenticate_scope!, :except => [:cancel]

  # ///////////////////////////// 

  before_filter :admin_or_current_user, only: [:show, :index, :update, :destroy]

  # /////////////////////////////


  private

  # Taken from each of the following actions (sign_up_params, and account_update_params): 
  #             :is_a_coach, :is_an_admin,

  def admin_or_current_user
    if current_user != nil
      redirect_to "/" unless current_user.is_an_admin? || @user.id == current_user.id
    else
      redirect_to "/"
    end
  end

  # TODO: Make these functions set the admin and coach permissions to false.

  def sign_up_params
    # See above for removed parameters
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :is_an_admin, :is_a_coach)
  end

  def account_update_params
    # See above for removed parameters
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :is_an_admin, :is_a_coach)
  end
end