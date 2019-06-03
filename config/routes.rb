Rails.application.routes.draw do
  root 'home#index'
  post 'home/longin', to: 'home#login'
  resources :users
end
