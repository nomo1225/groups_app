Rails.application.routes.draw do
  root to: 'toppages#index'
  get 'about', to: 'toppages#about'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'mygroups/:id/plans', to: 'mygroups#index'
  get 'mygroups/:id/members', to: 'mygroups#members'
  
  get 'join', to: 'relationships#new'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]
  
  resources :mygroups, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :notices, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :plans, only: [:new, :create, :show, :edit, :update, :destroy] do
    member do
      get :attenders
    end
  end
  resources :attendances, only: [:create, :destroy]
  
end
