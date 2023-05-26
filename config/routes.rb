Rails.application.routes.draw do
  resources :films
  resources :people
  resources :planets
  resources :users
  post '/auth/login', to: 'authentication#login'

  post 'password/forgot', to: 'passwords#forgot'
  post 'password/reset', to: 'passwords#reset'
end
