Rails.application.routes.draw do
  
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'home_about'
  # サインアップページをルートパスにする
  
  resources :books, only: [:new, :index, :show, :edit, :update, :create, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:edit, :update, :index, :show]
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

