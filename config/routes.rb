Rails.application.routes.draw do
  resources :patients
  get 'home_user/index'

  root 'home#index'
  post 'home/longin', to: 'home#login'
  post 'home/logout', to: 'home#logout'
  get 'home_admin/index', to: 'home_admin#index'
  post 'users/:id/active', to: 'users#activate', as: :activate_user
  post 'users/:id/change_password', to: 'users#change_password', as: :change_password
  get 'users/:id/change_password', to: 'users#change_password_view', as: :change_password_view
  post 'offered_exams/:id/activate', to: 'offered_exams#active_exam', as: :activate_offered_exam
  resources :users
  resources :offered_exams
end
