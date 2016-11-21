Rails.application.routes.draw do

  resources :group_messages
  resources :groups
  resources :group_memberships
  resources :admin_messages
  resources :plans
  resources :mentorships
  resources :messages
  devise_for :users, :controllers => { registrations: 'registrations' }

  # ------------This is the newer root, with the new admin message form:

  root to: "admin_messages#landing_page"
  

  # ---------------Dashboard

  get "/blog" => "home#blog"

  get "/user/dashboard" => "dashboard#view"

  get "user/dashboard/:active_user_id" => "dashboard#view"

  get "group/dashboard" => "dashboard#group_view"

  get "group/dashboard/:active_group_id" => "dashboard#group_view"

  get "/toggle_coach/:target_user_id" => "dashboard#admin_toggle_coach_permissions"

  get "/toggle_admin/:target_user_id" => "dashboard#admin_toggle_admin_permissions"

  get "activate_user/:target_user_id" => "dashboard#admin_activate_user"

  get "/" => "admin_messages#landing_page"

  #/////////////////////////////

  #Concerning: devise_for :users, :controllers => { registrations: 'registrations' }

  # This action from above tells Devise to use my custom registrations_controller.rb in order to accomodate first_name, last_name, is_a_coach, and is_an_admin columns in our User model (http://jacopretorius.net/2014/03/adding-custom-fields-to-your-devise-user-model-in-rails-4.html):

  #/////////////////////////////
  
end
