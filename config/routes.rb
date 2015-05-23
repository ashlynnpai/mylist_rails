Rails.application.routes.draw do

  root to: 'statics#index'
  
  resources :casts, only: [:index, :update, :show] do
    collection do
      post 'makelist'
    end
  end
  
  put 'toggle_watched', to: 'casts#toggle_watched'
  
  resources :users, only: [:new, :create] do
    
  end
  
  resource :dashboard, only: [:show]
  
  get '/register', to: 'users#new'  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
