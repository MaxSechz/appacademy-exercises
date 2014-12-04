Ninety9Cats::Application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:create, :new]

end
