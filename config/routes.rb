Rails.application.routes.draw do
  get 'home/about' => 'homes#about'
  get '/search' => 'search#search'
  root 'homes#top'
  devise_for :users
  
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  resources :books,only: [:show,:index,:edit,:create,:update,:destroy] do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end
  
  
end