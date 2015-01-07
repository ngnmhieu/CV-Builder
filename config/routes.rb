Rails.application.routes.draw do
  get '/' => 'pages#index', as: 'root'

  resources :resumes, except: [:new] do
    resources :simplelists, only: [:create, :destroy] do
      resources :simplelistitems, only: [:create, :destroy]
    end

    resources :worklists, only: [:create, :destroy] do
      resources :workitems, only: [:create, :destroy]
    end

    resources :textsections, only: [:create, :destroy]
  end

  get  'register' => 'users#register', as: 'register'
  post 'register' => 'users#create', as: 'create_user'
  get  'login' => 'users#login', as: 'login'
  post 'login' => 'users#authenticate', as: 'authenticate'
  get  'logout' => 'users#logout', as: 'logout'


end
