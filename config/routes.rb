Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  scope controller: :pages do
    get 'about', 'conditions', 'estimation', 'contacts', 'question', 'reviews', 'profile'
  end

  namespace :admin do
    get '/', to: 'loans#index'

    resources :callback_requests, only: [:index]
    resources :loans, only: [:index, :show]
    resources :users, only: [:index, :show]
    resources :reviews, only: [:index, :edit, :update]
  end

  resources :callback_requests
  resources :loans do
    put :make_advanced_payment_request, on: :member
  end
  resources :reviews, only: [:create]
  resource :user, only: [:update]
end
