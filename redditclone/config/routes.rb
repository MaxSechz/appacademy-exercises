Rails.application.routes.draw do
  root to: 'subs#index'

  resources :users, only: [:new, :index, :create]

  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: [:destroy]

  resources :posts, except: [:index, :destroy] do
    resources :comments, only: [:new]
  end

  resources :comments, except: [:new, :index]

end
