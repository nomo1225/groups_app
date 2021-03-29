Rails.application.routes.draw do
  root to: 'toppages#index'
  get 'about', to: 'toppages#about'
  get 'terms', to: 'toppages#terms'
  get 'privacy_policy', to: 'toppages#privacy_policy'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'mygroups/:id/plans', to: 'mygroups#index'
  get 'mygroups/:id/members', to: 'mygroups#members'
  
  get 'join', to: 'relationships#new'
  
  get 'signup', to: 'users#new'
  get 'forget', to: 'users#forget'
  post 'forget', to: 'users#forgetmail'
  get 'reset_password', to: 'users#resetpass'
  post 'reset_password', to: 'users#runresetpass'
  
  resources :users, only: [:index, :create, :edit, :update, :destroy]
  
  resources :mygroups, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :notices, only: [:new]
    resources :plans, only: [:new]
  end
  resources :relationships, only: [:create, :destroy]
  resources :notices, only: [:create, :show, :edit, :update, :destroy]
  resources :plans, only: [:create, :show, :edit, :update, :destroy] do
    member do
      get :attenders
    end
  end
  resources :attendances, only: [:create, :destroy]
  
end
