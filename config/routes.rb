Rails.application.routes.draw do
  root "users#new"
  resources :users, only: %i[index show new create]
end
