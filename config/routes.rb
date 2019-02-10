Rails.application.routes.draw do
  
  resource :alerts do
    collection do
      post 'reply'
      post 'create_alert'
    end
  end

  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks'}
  Shrine.plugin :upload_endpoint
  
  post 'alerts/reply'
  
  resources :images, only: [:new, :create, :index, :edit, :update]
  resources :resource_requests, only: [:create]

  get "/user_schedule/full_calendar" => "user_schedules#full_calendar"
  get "/user_schedule/user_create_new" => "user_schedules#user_create_new"

  get "/meet_us" => "home#meet_us"
  
  root to: "dashboard#view"
  mount ImageUploader.upload_endpoint(:cache) => "/images/upload"

  post "/assign_company_id/:target_user_id/:company_id" => "dashboard#super_admin_assign_company_id_to_new_user"

  get "/images/index" => "images#index"

  get "/notification_preferences" => "notification_preferences#index"
  post '/notification_preferences/enable_notification/:reason/:type' => 'notification_preferences#enable_notification'
  post '/notification_preferences/disable_notification/:reason/:type' => 'notification_preferences#disable_notification'

  post '/twilio/voice' => 'twilio#voice'

  get "/alerts/send_email" => "alerts#send_email"
  post "/alerts/send_notifications/:event/:createdModelId" => "alerts#send_notifications"

  get "/landing_page" => "admin_messages#landing_page"
  get "/download_book_resources" => "admin_messages#download_book_resources"
  get "/blog" => "home#blog"
  get "/test" => "home#test"

  get "/user/dashboard" => "dashboard#view"
  get "/user/dashboard/:active_user_id" => "dashboard#view"
  get "/user/group-dashboard" => "dashboard#group_view"
  get "/user/group-dashboard/:active_group_id" => "dashboard#group_view"

  get "/toggle_coach/:target_user_id" => "dashboard#admin_toggle_coach_permissions"
  get "/toggle_admin/:target_user_id" => "dashboard#admin_toggle_admin_permissions"
  get "/toggle_active/:target_user_id" => "dashboard#admin_toggle_active"
  get "/toggle_deleted/:target_user_id" => "dashboard#admin_toggle_deleted"
  get "/activate_user/:target_user_id" => "dashboard#admin_activate_user"

  resources :tasks
  resources :user_schedules
  resources :schedules
  # resources :notification_preferences
  resources :group_messages
  resources :groups
  resources :group_memberships
  resources :admin_messages
  resources :plans
  resources :mentorships
  resources :messages
  resources :bio_questions
  resources :bio_answers
  resources :bios
  resources :resources
  resources :resource_types
  resources :book_resources
  resources :user_emailer
  resources :companies
  resources :book_resources
  resources :resources
  resources :quotes
  resources :content_fields

  get "/" => "dashboard#view"

end
