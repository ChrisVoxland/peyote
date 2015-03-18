Rails.application.routes.draw do
  root "landing_page#index"

  match "home" => "home#index", via: :get

  get 'home/index', :as =>"user_root"
  get 'landing_page/index'
  get 'omniauth_callbacks_controller/google_oath2'

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :events, :only => [:create]
end
