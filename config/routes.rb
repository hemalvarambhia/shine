Rails.application.routes.draw do
  devise_for :users
  get 'angular_test', to: 'angular_test#index'
  
  root 'dashboard#index'
  resources :customers, only: [ :index ]
end
