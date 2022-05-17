Rails.application.routes.draw do
  resource :users, only: [:create]

  post '/authentication/login'
end
