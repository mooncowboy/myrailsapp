Rails.application.routes.draw do
  resources :artists
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "artists#index"

  resources :artists do
    collection do
      get :search
    end
  end

  # Spotify routes
  get '/spotify/search', to: 'spotify#search'
  post '/spotify/add_multiple', to: 'spotify#add_multiple'
end
