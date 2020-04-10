Rails.application.routes.draw do
  get 'welcome/index'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'users/show'
  get 'users/edit'
  post 'users/update'
  delete 'users/destroy'  
  resources :users, only: [:create]
  resources :sessions, only: [:create]

  resources :articles do 
    resources :comments
  end

  resources :comments do
    resources :comments
  end

  root 'welcome#index'

end
