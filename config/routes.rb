Rails.application.routes.draw do
  devise_for :users
  get 'home', to: 'home#top'
  get 'home/about', to: 'home#about'
  root to: 'home#top'
  resources :books
  resources :users, only: [:show, :index, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end