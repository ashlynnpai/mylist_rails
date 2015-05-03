Rails.application.routes.draw do

  root to: 'casts#index'
  
  resources :casts, only: [:index] do
    
  end
  
  resources :users, only: [:new, :create] do
    
  end
  
  get '/register', to: 'users#new'  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
