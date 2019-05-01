Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :users
      resources :conversations
      resources :messages

      post '/login', to: 'auth#create'
      get '/auto_login', to: 'auth#auto_login'
      
      mount ActionCable.server => '/cable'
    end
  end
end
