Rails.application.routes.draw do
  get 'calendar', to: 'calendar#index'
  resources :companies
  resources :contacts
  resources :messages do
    collection do
      get 'sent'
      get 'spam'
      get 'drafts'
      get 'trash'
      put 'ajax_update_company'
    end
  end
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
