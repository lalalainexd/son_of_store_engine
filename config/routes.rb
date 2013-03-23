StoreEngine::Application.routes.draw do
  resources :products
  resources :users
  resources :sessions
  
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "home/show"

  root :to => 'home#show'
end
