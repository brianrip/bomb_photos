Rails.application.routes.draw do
  root to: "categories#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, only: [:new, :create, :update, :edit]
  get "/dashboard", to: "users#show"

  namespace :admin do
    get "/dashboard", to: "users#show"
    resources :orders, only: [:index, :update, :show]
    resources :photos, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :cart_gifs, only: [:create]
  get "/cart", to: "cart_gifs#show"
  delete "/cart", to: "cart_gifs#destroy"
  patch "/cart", to: "cart_gifs#update"

  resources :orders, only: [:index, :show, :create, :new]

  resources :photos, only: [:index, :show, :create]

  put "/retire", to: "gifs#update"

  resources :charities, only: [:index, :show]

  resources :categories, only: [:index]
  get "/tag/:name", :to => "tags#show", as: :tag

  resources :charges
end
