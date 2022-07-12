Rails.application.routes.draw do
  
  #ルーティング変更
  devise_for :users,skip: [:passwords], controllers: {
  sessions:      'public/sessions',
  registrations: 'public/registrations'
  }
  
  #会員ルーティング
  scope module: :public do
  root to: "homes#top"
  resources :posts
   resources :users, only: [:show, :edit, :update] do
    collection do
      get 'unsubscribe'
      patch 'withdraw'
    end
   end
  end
  
end
