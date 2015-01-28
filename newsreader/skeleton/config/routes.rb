NewsReader::Application.routes.draw do
  namespace :api do
    resources :feeds, only: [:index, :create, :show, :destroy] do
      resources :entries, only: [:index]
    end
  end

  resources :users
  resource :session, only: [:new, :create, :destroy]
  root to: "static_pages#index"
end
