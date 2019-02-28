Rails.application.routes.draw do
  namespace :v1 do
    resources :items, only: :index
    resources :orders, only: :create
  end
end
