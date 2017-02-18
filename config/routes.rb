Rails.application.routes.draw do

  get 'alerts/reply'

  resource :alerts do
    collection do
      post 'reply'
    end
  end

  resources :group_messages
  resources :groups
  resources :group_memberships
  resources :admin_messages
  resources :plans
  resources :mentorships
  resources :messages 
  devise_for :users, controllers: {sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'registrations'}

  # ------------This is the newer root, with the new admin message form:

  #root to: "admin_messages#landing_page"
  
  root to: "dashboard#view" # <-- Root is to Dashboard. At the top of the controller, this route will redirect to the LANDING PAGE (yet undefined), unless user is signed in.

  # ---------------Dashboard

  # route at login directly to the dashboard.

  get "/landing_page" => "admin_messages#landing_page"

  get "/blog" => "home#blog"

  get "/user/dashboard" => "dashboard#view"

  get "/user/dashboard/:active_user_id" => "dashboard#view"

  get "/user/group-dashboard" => "dashboard#group_view"

  get "/user/group-dashboard/:active_group_id" => "dashboard#group_view"

  get "/toggle_coach/:target_user_id" => "dashboard#admin_toggle_coach_permissions"

  get "/toggle_admin/:target_user_id" => "dashboard#admin_toggle_admin_permissions"

  get "/activate_user/:target_user_id" => "dashboard#admin_activate_user"

  # get "/" => "admin_messages#landing_page"

  get "/" => "dashboard#view"

  #/////////////////////////////

  #Concerning: devise_for :users, :controllers => { registrations: 'registrations' }

  # This action from above tells Devise to use my custom registrations_controller.rb in order to accomodate first_name, last_name, is_a_coach, and is_an_admin columns in our User model (http://jacopretorius.net/2014/03/adding-custom-fields-to-your-devise-user-model-in-rails-4.html):

  #/////////////////////////////
  
end
