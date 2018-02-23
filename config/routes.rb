Rails.application.routes.draw do
  root to: "home#index"

  get "iframe_cookies_fix_redirect" => "lti_launches#iframe_cookies_fix_redirect"
  get "relaunch_lti_tool" => "lti_launches#relaunch_lti_tool"

  resources :lti_launches do
    collection do
      post :index
      get :launch
    end
    member do
      post :show
    end
  end

  devise_for :users, controllers: {
    sessions: "sessions",
    registrations: "registrations",
    omniauth_callbacks: "omniauth_callbacks",
  }

  as :user do
    get     "/auth/failure"         => "sessions#new"
    get     "users/auth/:provider"  => "users/omniauth_callbacks#passthru"
    get     "sign_in"               => "sessions#new"
    post    "sign_in"               => "sessions#create"
    get     "sign_up"               => "devise/registrations#new"
    delete  "sign_out"              => "sessions#destroy"
    get     "sign_out"              => "sessions#destroy"
  end

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
    end

    resources :canvas_accounts, only: [:index]
    resources :sites
    resources :lti_content_item_selection, only: [:create]
    resources :lti_launches

    resources :ims_exports do
      member do
        get :status
      end
    end
    resources :ims_imports, only: [:create]
  end

  get "api/canvas" => "api/canvas_proxy#proxy"
  post "api/canvas" => "api/canvas_proxy#proxy"
  put "api/canvas" => "api/canvas_proxy#proxy"
  delete "api/canvas" => "api/canvas_proxy#proxy"
end
