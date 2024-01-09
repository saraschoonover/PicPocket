Rails.application.routes.draw do
  resources :likes
  resources :photos
  devise_for :likes
  devise_for :photos
  devise_for :users
  get "profile", to: "users#profile", as: "profile"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "photos#index"
end
