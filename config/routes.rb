Rails.application.routes.draw do
  devise_for :users
  get 'prototypes/index'
  root to: "prototypes#index"
  
  resources :users

  resources :prototypes do
    resources :comments
  end
end
