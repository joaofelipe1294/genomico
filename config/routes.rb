Rails.application.routes.draw do
  get 'home_admin/index'

  root 'home#index'
  post 'home/longin', to: 'home#login'
  resources :users
end
