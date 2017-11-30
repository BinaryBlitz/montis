Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  scope controller: :pages do
    get 'about', 'conditions', 'contacts'
    # get 'consent', 'question', 'reviews'
  end
end
