Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  mount ActionCable.server => "/cable"
  
  namespace :api do
    namespace :v1 do
      
      resources :users, only: [:index, :update, :delete]
      resources :friends, only: [:index, :create, :delete]
      resources :conversations, only: [:index, :create]
      resources :messages, only: [:create]
      
      post '/signup', to: 'users#create'
      
      post '/login', to: 'auth#login'
      get '/auto_login', to: 'auth#auto_login'

    end
  end
end
