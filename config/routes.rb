Rails.application.routes.draw do
  resources :contacts
  resources :messages
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
