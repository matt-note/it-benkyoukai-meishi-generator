Rails.application.routes.draw do
  root "users#new"
  resources :users, only: %i[index show new create]
  get "about", to: "static_pages#about"
  match "*path" => "application#routing_error", via: :all
end
