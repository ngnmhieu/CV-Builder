Rails.application.routes.draw do
  get '/' => 'pages#index', as: 'root'

  resources :resumes do
    resources :simplelists do
      resources :simplelistitems
    end
    resources :multiline_lists do
      resources :multiline_list_items
    end
    resources :textsections
  end

  get  'register' => 'users#register', as: 'register'
  post 'register' => 'users#create', as: 'create_user'
  get  'login' => 'users#login', as: 'login'
  post 'login' => 'users#authenticate', as: 'authenticate'
  get  'logout' => 'users#logout', as: 'logout'
end
