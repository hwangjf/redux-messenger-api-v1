Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :users
      resources :conversations, only: [:index, :create]
      resources :messages, only: [:create]

      post '/signup', to: 'users#signup'
      post '/login', to: 'users#login' 
      get '/auto_login', to: 'users#auto_login'
      
      mount ActionCable.server => '/cable'
    end
  end
end
