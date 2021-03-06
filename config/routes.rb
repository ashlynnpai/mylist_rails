Rails.application.routes.draw do

  root to: 'statics#index'
  
  resources :casts, only: [:index, :update] do
    collection do
      post 'makelist'
    end
  end
  
  put 'toggle_watched', to: 'casts#toggle_watched'
  patch 'modify_comment', to: 'casts#modify_comment'
  
  resources :users, only: [:new, :create, :show, :edit] do
    
  end
  
  patch 'make_private', to: 'users#make_private'
  patch 'make_public', to: 'users#make_public'
  
  resources :railscasts, only: [:show] do
    resources :notes, only: [:create, :edit]    
  end
  
  
  
  resource :dashboard, only: [:show]
  
  resource :completion, only: [:show]
  
  get '/register', to: 'users#new'  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
