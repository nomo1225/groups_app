Rails.application.routes.draw do
  root to:                  'toppages#index'
  get 'terms', to:          'toppages#terms'
  get 'privacy_policy', to: 'toppages#privacy_policy'
  get 'question', to:       'toppages#question'
  get 'how_to_use', to:     'toppages#how_to_use'
  get 'omikuji', to:        'omikujis#show'
  get 'sitemap_page', to:   'toppages#sitemap_page'
  
  get 'login', to:     'sessions#new'
  post 'login', to:    'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'mygroups/:id/plans', to:   'mygroups#index', as: 'mygroup_plans' #as: '~'でpathを作成
  get 'mygroups/:id/members', to: 'mygroups#members'
  
  get 'join', to: 'relationships#new'
  
  get 'signup', to:          'users#new'
  get 'forget', to:          'users#forget'
  post 'forget', to:         'users#forgetmail'
  get 'reset_password', to:  'users#resetpass'
  post 'reset_password', to: 'users#runresetpass'
  post 'year_total', to:     'accounts#year_total'
  get 'total', to:           'accounts#total', as: 'total'
  
  resources :users, only: [:index, :create, :edit, :update, :destroy]
  
  # グループに紐づく項目の新規作成時にmygroup_idを持たせる
  resources :mygroups,  only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :notices, only: [:new]
    resources :plans,   only: [:new]
    resources :discussions, only: [:new]
    resources :opinions,    only: [:new]
    resources :accounts, only: [:new]
  end
  resources :relationships, only: [:create, :destroy]
  resources :notices,       only: [:create, :show, :edit, :update, :destroy]
  resources :plans,         only: [:create, :show, :edit, :update, :destroy] do
    member do
      get :attenders
    end
  end
  resources :attendances, only: [:create, :destroy]
  resources :inquiry,     only: [:new, :create]
  resources :discussions, only: [:create, :show, :edit, :update, :destroy]
  resources :opinions,    only: [:create, :index, :destroy]
  resources :accounts,    only: [:create, :show, :index, :edit, :update, :destroy]
  
  get '/sitemap', to: redirect("https://s3-ap-northeast-1.amazonaws.com/#{ENV['S3_BUCKET_KEY']}/sitemap.xml.gz")
end
