Rails.application.routes.draw do

  root to: 'casts#index'
  
  resources :casts, only: [:index] do
    
  end
  
  resources :users, only: [:new, :create] do
    
  end
end
