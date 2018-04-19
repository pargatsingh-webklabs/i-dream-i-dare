Rails.application.routes.draw do

  post 'alerts/reply'

  resource :alerts do
    collection do
      post 'reply'
      post 'create_alert'
    end
  end

  resources :group_messages
  resources :groups
  resources :group_memberships
  resources :admin_messages
  resources :plans
  resources :mentorships
  resources :messages 
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'registrations'}

  root to: "dashboard#view" 

  get "/alerts/send_email" => "alerts#send_email"
  get "/landing_page" => "admin_messages#landing_page"
  get "/blog" => "home#blog"

  get "/user/dashboard" => "dashboard#view"
  get "/user/dashboard/:active_user_id" => "dashboard#view"
  get "/user/group-dashboard" => "dashboard#group_view"
  get "/user/group-dashboard/:active_group_id" => "dashboard#group_view"
  
  get "/toggle_coach/:target_user_id" => "dashboard#admin_toggle_coach_permissions"
  get "/toggle_admin/:target_user_id" => "dashboard#admin_toggle_admin_permissions"
  get "/activate_user/:target_user_id" => "dashboard#admin_activate_user"
  get "/" => "dashboard#view"
  
end
