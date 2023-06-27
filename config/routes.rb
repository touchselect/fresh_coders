Rails.application.routes.draw do
  # 会員用
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions:      'public/sessions'
  }
  
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end
  
  # 管理者用
  devise_for :admin, controllers: {
    sessions:      "admin/sessions"
  }
  
  scope module: :public do
    root to:  'homes#top'
    resources :users, only: [:show, :edit, :update] do
      member do
        get :following, :followers
      end
      resource :follows, only: [:create, :destroy]
    end
    get   'users'               => redirect('users/sign_up')
    get   'users/:id/favorites' => 'users#favorites', as: 'user_favorites'
    get   'users/:id/drafts'    => 'users#drafts',    as: 'user_drafts'
    get   'users/:id/following' => 'users#following', as: 'user_following'
    get   'users/:id/followed'  => 'users#followed',  as: 'user_followed'
    get   'users/:id/confirm'   => 'users#confirm',   as: 'user_confirm'
    patch 'users/:id/withdraw'  => 'users#withdraw',  as: 'user_withdraw'
    resources :posts do
      resource  :favorites, only: [:create, :destroy]
      resources :comments,  only: [:create, :destroy]
      resource  :draft,     only: [:show, :edit,:update, :destroy]
    end
    resource :category, only: [:create]
  end

  namespace :admin do
    root to: 'homes#top'
    get   'homes/menu'          => 'homes#menu',      as: 'menu'
    resources :users,    only: [:index, :show, :edit, :update]
    get   'users/:id/favorites' => 'users#favorites', as: 'user_favorites'
    get   'users/:id/drafts'    => 'users#drafts',    as: 'user_drafts'
    get   'users/:id/following' => 'users#following', as: 'user_following'
    get   'users/:id/followed'  => 'users#followed',  as: 'user_followed'
    resources :posts,    only: [:index, :show, :destroy] do
      resources :comments,  only: [:destroy]
      resource  :draft,     only: [:show, :edit,:update, :destroy]
    end
    resources :categories, only: [:create, :index, :edit, :update, :destroy]
  end

end
