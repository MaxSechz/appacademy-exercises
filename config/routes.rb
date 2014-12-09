Rails.application.routes.draw do
  root to: 'users#index'

  resources :users, only: [:new, :index, :create]

  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: [:destroy]
end
