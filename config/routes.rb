Rails.application.routes.draw do
  
  #ルーティング変更
  devise_for :users,skip: [:passwords], controllers: {
  sessions:      'public/sessions',
  registrations: 'public/registrations'
  }
  
  #会員ルーティング
  namespace :public do
  root to: "homes#top"
  end
  
end
