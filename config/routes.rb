Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resource :session
  resources :passwords, param: :token
  resource :user, except: %i[show destroy]
  resources :veneers, except: :show
  resources :kitchen
  resources :articles, path: "/a" do
    collection do
      get "(/p/:page)", to: "articles#index"
      get "/t/:tags(/p/:page)", to: "articles#index", constraints: { tags: /\S+/ }, as: :tagged
    end
  end

  root to: "articles#index"
end
