Rails.application.routes.draw do
  root to: "volunteers#index"
  resources :organizations, only: :index
  resources :volunteers, only: [:index, :show]
end