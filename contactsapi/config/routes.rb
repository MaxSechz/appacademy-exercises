Rails.application.routes.draw do
  resources :users, only: [:index, :create, :destroy, :update, :show] do
    resources :contacts, only: :index
    resources :comments, only: :index
  end

  resources :contacts, only: [:create, :destroy, :show, :update] do
    resources :comments, only: :index
  end
  resources :comments, only: [:create, :destroy, :show, :update]
  resources :contact_shares, only: [:create, :destroy]
end
