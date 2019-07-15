Rails.application.routes.draw do
  get 'backups/download/:id', to: 'backups#download', as: :backup_download
  get 'backups/index', to: 'backups#index', as: :backups
  get 'panels/exams'
  get 'panels/attendances'
  resources :work_maps
  resources :hospitals
  root 'home#index'
  get 'home_user/index'
  post 'home/longin', to: 'home#login'
  post 'home/logout', to: 'home#logout'
  get 'home_admin/index', to: 'home_admin#index'

  post 'users/:id/active', to: 'users#activate', as: :activate_user
  post 'users/:id/change_password', to: 'users#change_password', as: :change_password
  get 'users/:id/change_password', to: 'users#change_password_view', as: :change_password_view

  get 'exams/:id/edit', to: 'exams#edit', as: :edit_exam
  get 'exams/:id/start', to: 'exams#start', as: :start_exam
  patch 'exams/:id', to: 'exams#update', as: :update_exam
  patch 'exams/:id/initiate', to: 'exams#initiate', as: :initiate_exam
  patch 'exams/:id/tecnical-released', to: 'exams#tecnical_released', as: :change_to_tecnical_released
  patch 'exams/:id/in-repeat', to: 'exams#in_repeat', as: :change_to_in_repeat
  patch 'exams/:id/completed', to: 'exams#completed', as: :change_to_completed

  get 'samples/new/attendance/:id', to: 'samples#new', as: :new_sample
  get 'subsamples/sample/:id/new', to: 'subsamples#new', as: :new_sub_sample

  get 'attendances/:id/workflow', to: 'attendances#workflow', as: :workflow
  get 'attendances/new/patient/:id', to: 'attendances#new', as: :new_attendance
  get 'attendances/lis_code', to: 'attendances#find_by_lis_code', as: :lis_search
  patch 'attendances/:id/report', to: 'attendances#add_report', as: :add_report

  get 'offered_exams/field/:id', to: 'offered_exams#exams_per_field', as: :exam_per_field
  post 'offered_exams/:id/activate', to: 'offered_exams#active_exam', as: :acitvate_offered_exam

  get 'patient/:id/attendances', to: 'attendances#attendances_from_patient', as: :attendances_from_patient

  resources :subsamples
  resources :samples, except: [:new]
  resources :users
  resources :attendances, except: [:new]
  resources :offered_exams
  resources :patients, except: [:delete]
  resources :subsamples
end
