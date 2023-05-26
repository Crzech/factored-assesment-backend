Rails.application.routes.draw do
  resources :films
  resources :people
  resources :planets
  resources :users
  post '/auth/login', to: 'authentication#login'
end
