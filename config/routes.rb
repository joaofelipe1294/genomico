Rails.application.routes.draw do
  get 'sub_samples/edit'
  get 'sub_samples/sample/:id/new', to: 'sub_samples#new', as: :new_sub_sample
  root 'home#index'
  get 'home_user/index'
  post 'home/longin', to: 'home#login'
  post 'home/logout', to: 'home#logout'
  get 'home_admin/index', to: 'home_admin#index'
  post 'users/:id/active', to: 'users#activate', as: :activate_user
  post 'users/:id/change_password', to: 'users#change_password', as: :change_password
  get 'users/:id/change_password', to: 'users#change_password_view', as: :change_password_view
  post 'offered_exams/:id/activate', to: 'offered_exams#active_exam', as: :activate_offered_exam
  get 'attendances/new/patient/:id', to: 'attendances#new', as: :new_attendance
  get 'offered_exams/field/:id', to: 'offered_exams#exams_per_field', as: :exam_per_field
  get 'attendances/:id/workflow', to: 'attendances#workflow', as: :workflow
  get 'samples/new/attendance/:id', to: 'samples#new', as: :new_sample
  get 'patient/:id/attendances', to: 'attendances#attendances_from_patient', as: :attendances_from_patient
  get 'attendances/lis_code', to: 'attendances#find_by_lis_code', as: :lis_search
  resources :samples, except: [:new]
  resources :users
  resources :attendances, except: [:new]
  resources :offered_exams
  resources :patients, except: [:delete]
end
