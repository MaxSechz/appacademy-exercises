Rails.application.routes.draw do
  resources :users, only: [:index, :create, :destroy, :update, :show] do
    resources :contacts, only: [:index, :destroy, :show, :update]
  end
  resources :contacts, only: [:create]
end
