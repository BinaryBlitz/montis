Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  scope controller: :pages do
    get 'about', 'conditions', 'estimation', 'contacts', 'question', 'reviews'
  end

  namespace :admin do
    resources :callback_requests
    resources :loans
  end

  resources :callback_requests
  resources :loans
end
