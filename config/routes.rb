Rails.application.routes.draw do

  resources :admin_messages
  resources :plans
  resources :mentorships
  resources :messages
  devise_for :users, :controllers => { registrations: 'registrations' }
  
  # ---------This is the old root, sans new admin message form:

  # root to: "home#index"


  # ------------This is the newer root, with the new admin message form:

  root to: "admin_messages#landing_page"


  # ---------------Dashboard

  get "/user/dashboard" => "dashboard#view"

  get "user/dashboard/:active_user_id" => "dashboard#view"

  get "/permissions" => "dashboard#admin_edit_permissions"


  #/////////////////////////////

  #Concerning: devise_for :users, :controllers => { registrations: 'registrations' }

  # This action from above tells Devise to use my custom registrations_controller.rb in order to accomodate first_name, last_name, is_a_coach, and is_an_admin columns in our User model (http://jacopretorius.net/2014/03/adding-custom-fields-to-your-devise-user-model-in-rails-4.html):

  #/////////////////////////////
  
end
