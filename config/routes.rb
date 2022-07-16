Rails.application.routes.draw do
  
  #ルーティング変更
  devise_for :users,skip: [:passwords], controllers: {
  sessions:      'public/sessions',
  registrations: 'public/registrations'
  }
  
  #ゲストユーザー機能
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  
  #会員ルーティング
  scope module: :public do
  root to: "homes#top"
  get 'search' => "searches#search"
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
   end
   resources :users, only: [:show, :edit, :update] do
    member do
      get :favorites
    end
    collection do
      get 'unsubscribe'
      patch 'withdraw'
    end
   end
  end
  
end
