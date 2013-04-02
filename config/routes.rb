StoreEngine::Application.routes.draw do
  resources :orders

  match "code" => redirect("http://www.github.com/jmejia/store_engine"), :as => :code

  resources :line_items do
    member do
      put :increase
      put :decrease
    end
  end

  resources :carts
  resources :products
  resources :categories

  resources :users
  resources :sessions

  get "admin" => "products#index", :as => "admin"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "home/show"
  put 'product/:id/retire' => 'products#retire', :as => 'retire_product'
  put 'product/:id/unretire' => 'products#unretire', :as => 'unretire_product'
  put "order/:id/change_status" => "orders#change_status", :as => "change_order_status"              

  root :to => 'home#show'
end
