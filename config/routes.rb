Rails.application.routes.draw do
  
  #管理者ルーティング
  devise_for :admin, skip: [:passwords], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
     root to: "posts#index"
     resources :users, only: [:show, :edit, :update, :index] 
     resources :posts, only: [:index, :show, :destroy] do
       resources :comments, only: [:destroy]
     end
  end
  
  
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
  get 'search_tag' => "posts#search_tag"
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
