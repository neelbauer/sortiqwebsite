Rails.application.routes.draw do
  # Session routes
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  # Dashboard
  get "dashboard", to: "dashboard#index"
  
  # Resources
  get "clients", to: "companies#clients"
  get "client_prospects", to: "companies#client_prospects"
  
  resources :companies do
    collection do
      get :bulk_upload_form
      post :bulk_upload
    end
    member do
      patch :toggle_client_status
    end
    resources :hiring_team_members, only: [:new, :create, :show, :edit, :update, :destroy]
  end
  
  resources :jobs
  resources :candidates
  
  # Recruiting Services
  get "recruiting_services", to: "dashboard#recruiting_services"
  
  # User password change
  get "change_password", to: "users#edit"
  patch "change_password", to: "users#update"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "sessions#new"
end
