Rails.application.routes.draw do
  get '/' => 'pages#index', as: 'root'

  resources :resumes, except: [:new] do
    resources :simplelists, only: [:create, :destroy] do
      resources :simpleitems, only: [:create, :destroy]
    end

    resources :worklists, only: [:create, :destroy] do
      resources :workitems, only: [:create, :destroy]
    end

    resources :textsections, only: [:create, :destroy]
  end

  get  'register'  => 'sessions#register', as: 'register'
  post 'register'  => 'sessions#create', as: 'create_user'
  get  'login'     => 'sessions#login', as: 'login'
  post 'login'     => 'sessions#auth_default_identity', as: 'authenticate'
  get  'logout'    => 'sessions#destroy', as: 'logout'
  

  get '/auth/:provider/callback' => 'sessions#auth_openid', as: 'oauth_callback'

end
