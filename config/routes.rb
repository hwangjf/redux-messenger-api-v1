Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index'
  mount ActionCable.server => "/cable"
  
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :update, :delete]
      resources :conversations, only: [:index, :create]
      resources :messages, only: [:create]
      
      post '/users/:id/friends', to: 'users#add_friend'
      get '/users/:id/friends', to: 'users#friends'
      
      post '/signup', to: 'users#create'
      post '/login', to: 'users#login' 
      get '/auto_login', to: 'auth#auto_login'

    end
  end
end
