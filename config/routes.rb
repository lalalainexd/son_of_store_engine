StoreEngine::Application.routes.draw do

  root :to => 'home#show'

  namespace :admin do
    resources :stores do
      put :activate
      put :decline
    end
  end

  resources :stores, :except => :index

  resources :trips

  resources :orders do
    member do
      put :change_status, :as => "change_status_on"
    end
  end

  resources :line_items do
    member do
      put :increase
      put :decrease
    end
  end

  resources :carts
  resources :products do
    member do
      put :retire
      put :unretire
    end
  end

  get "all_products" => "products#list"


  resources :categories

  get "profile" => "users#show"
  resources :users do
    match "/" => "stores#index"
  end

  resource :session

  get "my_cart" => "carts#show"
  # get "my_trip" => "trips#show"

  get "admin" => "products#index", :as => "admin"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "search" => "search#user_search", :as => "search"

  resources :stores
  scope "/:id" do
    match "/" => "stores#show", as: "home"
  end

  match "code" => redirect("http://www.github.com/jmejia/store_engine"), :as => :code
end
