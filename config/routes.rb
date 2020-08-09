Rails.application.routes.draw do

  get 'relationships/create'
  get 'relationships/destroy'
  root 'tweets#index'
  devise_for :users

  # ================ここをネスト(入れ子)した形に変更
  resources :tweets do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  #======================================


  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
