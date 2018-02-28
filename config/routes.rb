Rails.application.routes.draw do
  root to: 'toppages#index'
  
  # microposts/login でsessionsコントロールのnewアクションを実行
  # new.html.erbを表示
  get 'login', to: 'sessions#new'
  
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  
  get 'signup', to: 'users#new'
 
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
      get :favorites
    end
 
  end
  
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy, :index]
  
end