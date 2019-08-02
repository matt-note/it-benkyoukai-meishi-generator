Rails.application.routes.draw do
  root "users#new"
  resources :users, only: %i[index show new create]
  get "about", to: "static_pages#about"
end
