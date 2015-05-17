Rails.application.routes.draw do

  root to: 'casts#index'
  
  resources :casts, only: [:index, :update, :show] do
    collection do
      post 'makelist'
    end
  end
  
  resources :users, only: [:new, :create] do
    
  end
  
  resource :dashboard, only: [:show]
  
  get '/register', to: 'users#new'  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
