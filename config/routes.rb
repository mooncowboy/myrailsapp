Rails.application.routes.draw do
  resources :artists
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "artists#index"

  # Spotify routes
  get '/spotify/search', to: 'spotify#search'
end
