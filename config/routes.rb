Rails.application.routes.draw do

  root to: 'casts#index'
  
  resources :casts, only: [:index] do
    
  end
end
