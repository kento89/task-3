Rails.application.routes.draw do
  get 'home/about' => 'homes#about'
  root 'homes#top'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books,only: [:show,:index,:edit,:create,:update,:destroy]
end