Rails.application.routes.draw do
  devise_for :users
  resources :resource_settings, controllers: {
    registrations: 'users/registrations',
    registrations: 'users/sessions'
  }

  devise_scope :user do
    authenticated :user do
      root 'resource_settings#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'users/sessions#new', as: :unauthenticated_root
    end
  end


end
