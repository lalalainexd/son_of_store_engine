StoreEngine::Application.routes.draw do

  root :to => 'home#show'

  resources :users

  namespace :admin do
    get "dashboard/show"
    resources :stores do
      put :activate
      put :decline
      put :disable
      put :enable
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

#  resources :products do
#    member do
#      put :retire
#      put :unretire
#    end
#  end

  #get "all_products" => "products#list"



  get "profile" => "users#show"
  match "edit/profile" => "users#edit"


  resource :session

  get "my_cart" => "carts#show"
  # get "my_trip" => "trips#show"

 # get "admin" => "products#index", :as => "admin"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "search" => "search#user_search", :as => "search"

 # resources :stores

  scope "/:store_id" do

    resources :categories
    get "/" => "products#index", as: "home"
    resources :products, :only => :show

    namespace :admin do
      resources :products do
        member do
          put :retire
          put :unretire
        end
      end
      resources :orders
      post "create_admin" => "stores#create_admin"
      
    end
  end

#  match "code" => redirect("http://www.github.com/jmejia/store_engine"), :as => :code
end
