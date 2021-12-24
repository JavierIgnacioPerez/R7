Rails.application.routes.draw do
  resources :messages
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'landing#home'

  resources :landing, only: :sign_in do
    collection do
      post :sign_in
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
