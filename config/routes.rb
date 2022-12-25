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
    get "tweet_search"  => "searches#tweet_search"
    get "user_search"   => "searches#user_search"
    get "user_meat/:id" => "users#user_meat", as: "user_meat"
    patch "tweet/:id/update_display" => "tweets#update_display", as: "tweet_update_display"
    resources :notifications, only: [:index]
    resources :users, only: [:show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers"  => "relationships#followers",  as: "followers"
    end
    resources :tweets do
      resource  :favorites, only: [:show, :create, :destroy]
      resources :comments,  only: [:index, :create, :edit, :update, :destroy]
    end
  end

  namespace :admin do
    root "homes#top"
    get "users/no_active"
    get "tweets/no_active"
    get "tweet_search"   => "searches#tweet_search"
    get "user_search"    => "searches#user_search"
    delete ":id/destroy" => "searches#destroy", as: "search_tweet_destroy"
    patch "users/:id/update_status" => "users#update_status", as: "users_update_status"
    resources :users,  only: [:index, :show, :edit, :update]
    resources :meats,  only: [:new, :index, :create, :edit, :update]
    resources :achievements, only: [:new, :index, :create, :edit, :update]
    resources :tweets, only: [:index, :update, :destroy] do
      resources :comments, only: [:index, :update, :destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
