Rails.application.routes.draw do

  resources :content_fields
  post 'alerts/reply'

  resource :alerts do
    collection do
      post 'reply'
      post 'create_alert'
    end
  end
  resources :images, only: [:create]
  # resources :notification_preferences
  resources :group_messages
  resources :groups
  resources :group_memberships
  resources :admin_messages
  resources :plans
  resources :mentorships
  resources :messages
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'registrations'}

  root to: "dashboard#view"

  get "/notification_preferences" => "notification_preferences#index"
  post '/notification_preferences/enable_notification/:reason/:type' => 'notification_preferences#enable_notification'
  post '/notification_preferences/disable_notification/:reason/:type' => 'notification_preferences#disable_notification'

  post '/twilio/voice' => 'twilio#voice'

  get "/alerts/send_email" => "alerts#send_email"
  post "/alerts/send_notifications/:event/:createdModelId" => "alerts#send_notifications"

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
