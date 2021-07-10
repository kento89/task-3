Rails.application.routes.draw do
  get 'home/about' => 'homes#about'
  get '/search' => 'search#search'
  # get 'search_carender' => 'search#search_carender'
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
  
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  resource :search, only: [] do
    get :search_carender, on: :collection
  end
  
end