Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :portfolios

  devise_scope :user do
    authenticated :user do
      root 'portfolios#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'users/sessions#new', as: :unauthenticated_root
    end
  end


end
