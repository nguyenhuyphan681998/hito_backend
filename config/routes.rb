Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get  'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'auth/facebook/callback/' => 'sessions#create'
  get 'auth/failure/' => redirect('/')
  delete 'logout' => 'sessions#destroy'
    resources :users
    resources :sessions, only: [:create, :destroy]
    resources :account_activations, only: [:edit]
    resources :password_resets, only: [:new, :create, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
