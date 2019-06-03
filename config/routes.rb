Rails.application.routes.draw do
  root 'home#index'
  post 'home/longin', to: 'home#login'
  post 'home/logout', to: 'home#logout'
  get 'home_admin/index', to: 'home_admin#index'
  resources :users
end
