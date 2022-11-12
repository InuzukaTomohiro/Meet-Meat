Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

   devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }


  scope module: :public do
    root "homes#top"
    get "users/confirm"
    get "favorites/index"
    get "tweet_search" => "searches#tweet_search"
    get "user_search" => "searches#user_search"
    get "daily_eat/index"
    resources :notifications, only: [:index]
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers"  => "relationships#followers",  as: "followers"
    end
    resources :tweets do
      resource  :favorites, only: [:create, :destroy]
      resources :comments,  only: [:index, :create, :edit, :update, :destroy]
    end
  end

  namespace :admin do
    root "homes#top"
    resources :users,  only: [:index, :show, :edit, :update]
    resources :tweets, only: [:index, :show, :destroy]
    resources :meats,  only: [:index, :create, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
