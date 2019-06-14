Rails.application.routes.draw do
  
  resources :companies
  resources :book_resources
  resources :resources
  resources :quotes
  Shrine.plugin :upload_endpoint

  resources :content_fields
  post 'alerts/reply'

  resource :alerts do
    collection do
      post 'reply'
      post 'create_alert'
    end
  end

  resources :images, only: [:new, :create, :index, :edit, :update]
  resources :resource_requests, only: [:create]

  get "/bios/meet_us" => "bios#meet_us"
  
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

  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'registrations'}

  root to: "dashboard#view"
  mount ImageUploader.upload_endpoint(:cache) => "/images/upload"

  # post "user_emailer/send_book_resources/:email" => "user_emailer"

  post "/assign_company_id/:target_user_id/:company_id" => "dashboard#super_admin_assign_company_id_to_new_user"
  get "company_admin_login/:company_id" => "dashboard#super_admin_log_into_company"

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

  get "/" => "dashboard#view"


end
