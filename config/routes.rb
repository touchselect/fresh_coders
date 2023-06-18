Rails.application.routes.draw do
  
  scope module: :public do
    root to:  'homes#top'
    resources :users, only: [:show, :edit, :update] do
      member do
        get :following, :followers
      end
      resource :follows, only: [:create, :destroy]
    end
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
  end

  namespace :admin do
    root to: 'homes#top'
    resources :users,    only: [:index, :show, :edit, :update]
    resources :comments, only: [:destroy]
  end

  
# 会員用
devise_for :user, controllers: {
  registrations: "public/registrations",
  sessions:      'public/sessions'
}

# 管理者用
devise_for :admin, controllers: {
  sessions:      "admin/sessions"
}
end
