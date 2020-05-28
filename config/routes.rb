Rails.application.routes.draw do
  resources :resource_settings
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'resource_settings#index'
end
