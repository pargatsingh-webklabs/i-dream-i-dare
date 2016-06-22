Rails.application.routes.draw do
  resources :plans
  resources :mentorships
  resources :messages
  devise_for :users

  root to: "home#index"
  
end
