Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "boards#home"
  resources :boards do
    resources :states do
      resources :tasks do 
        resources :attachments
        member do
          patch :update_column 
        end
      end
    end 
    resources :labels
  end 
  resources :users
end
