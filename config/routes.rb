Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships,only: [:create,:destroy]
    get :followings,on: :member
    get :followers,on: :member
  end
  resources :books do
    resource :favorites,only: [:create,:destroy]
    resources :book_comments,only: [:create,:destroy]
  end
end