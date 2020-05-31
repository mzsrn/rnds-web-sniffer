Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :resource_settings do
    member do
      resource :portfolios
    end
  end

  devise_scope :user do
    authenticated :user do
      root 'resource_settings#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'users/sessions#new', as: :unauthenticated_root
    end
  end


end
