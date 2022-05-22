Rails.application.routes.draw do
  resource :users, only: [:create]
  resources :contacts

  post '/authentication/login'
end
