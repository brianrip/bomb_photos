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
    patch "/status/:id", to: "photos#change_status"
  end

  namespace :platform_admin do
    get "/dashboard", to: "studios#index"
  end

  resources :cart_photos, only: [:create]
  get "/cart", to: "cart_photos#show"
  delete "/cart", to: "cart_photos#destroy"
  patch "/cart", to: "cart_photos#update"

  resources :orders, only: [:index, :show, :create, :new]

  resources :photos, only: [:index, :show, :create]

  put "/retire", to: "gifs#update"

  resources :studios, only: [:index, :show]

  resources :categories, only: [:index]
  get "/categories/:slug", :to => "categories#show", as: :category

  resources :charges
end
