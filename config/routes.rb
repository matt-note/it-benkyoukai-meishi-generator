# frozen_string_literal: true

Rails.application.routes.draw do
  root 'users#new'
  resources :users, only: %i[show new create]
  get 'about', to: 'static_pages#about'
  get 'privacy', to: 'static_pages#privacy'
  get 'disclaimer', to: 'static_pages#disclaimer'
  match '*path' => 'application#routing_error', via: :all
end
