Rails.application.routes.draw do
  devise_for :users
  get 'dashboard/index'
  root 'dashboard#index'
  resources :customers, only: [ :index, :show ]
  get 'fake_billing', to: 'fake_billing#show'
end
