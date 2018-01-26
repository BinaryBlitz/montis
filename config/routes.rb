Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  scope controller: :pages do
    get 'about', 'conditions', 'estimation', 'contacts', 'question', 'reviews', 'profile'
  end

  namespace :admin do
    get '/', to: 'loans#index'

    resources :callback_requests
    resources :loans
  end

  resources :callback_requests
  resources :loans
  resources :users, only: [:show, :create]
end
