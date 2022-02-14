Rails.application.routes.draw do
  post "api/graphql", to: "api/graphql#execute"
  root to: "home#index"

  get "iframe_cookies_fix_redirect" => "lti_launches#iframe_cookies_fix_redirect"
  get "relaunch_lti_tool" => "lti_launches#relaunch_lti_tool"

  resources :jwks
  resources :public_keys
  resource :lti_config

  resources :lti_dynamic_registrations
  resources :lti_launches do
    collection do
      post :index
      get :launch
      get :init
      post :init
    end
    member do
      post :show
    end
  end

  resources :lti_deployments

  devise_for :users, controllers: {
    sessions: "sessions",
    registrations: "registrations",
    omniauth_callbacks: "omniauth_callbacks",
  }, skip: [:registrations]

  as :user do
    get     "/auth/failure"         => "sessions#new"
    get     "users/auth/:provider"  => "users/omniauth_callbacks#passthru"
    get     "sign_in"               => "sessions#new"
    post    "sign_in"               => "sessions#create"
    delete  "sign_out"              => "sessions#destroy"
    get     "sign_out"              => "sessions#destroy"
    get "users/edit" => "devise/registrations#edit", as: "edit_user_registration"
    put "users" => "devise/registrations#update", as: "user_registration"
  end

  resource :two_factor_settings, except: [:index, :show]

  resources :users

  namespace :admin do
    root to: "home#index"
  end

  namespace :api do
    resources :jwts
    resources :oauths

    resources :applications do
      resources :application_instances do
        member do
          get :check_auth
        end
      end
      resources :lti_install_keys
    end

    resources :canvas_accounts, only: [:index]
    resources :sites
    resources :lti_content_item_selection, only: [:create]
    resources :lti_deep_link_jwt, only: [:create]
    resources :lti_launches

    resources :ims_exports do
      member do
        get :status
      end
    end
    resources :ims_imports, only: [:create]
    resources :account_analytics, only: [:index]
  end

  get "api/canvas" => "api/canvas_proxy#proxy"
  post "api/canvas" => "api/canvas_proxy#proxy"
  put "api/canvas" => "api/canvas_proxy#proxy"
  delete "api/canvas" => "api/canvas_proxy#proxy"
end
