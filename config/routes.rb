Rails.application.routes.draw do

  get 'internal_codes/biomol_internal_codes', to: 'internal_codes#biomol_internal_codes', as: :biomol_internal_codes
  patch 'exams/:id/partial_released', to: 'exams#change_to_partial_released', as: :partial_released
  get 'exams/:id/partial_released', to: 'exams#partial_released', as: :change_to_partial_released
  get 'internal_codes/code/:code', to: 'internal_codes#show', as: :get_internal_code
  patch 'exams/:id/save_report', to: 'exams#save_exam_report', as: :save_exam_report
  get 'exams/:id/add_report', to: 'exams#add_report', as: :add_report_to_exam
  get 'internal_codes/imunofeno_internal_codes', to: 'internal_codes#imunofeno_internal_codes', as: :imunofeno_internal_codes
  get 'patients/:id/samples', to: 'patients#samples_from_patient', as: :samples_from_patient
  get 'patient/:id/exams', to: 'exams#exams_from_patient', as: :exams_from_patient
  post 'internal_codes/new/:id', to: 'internal_codes#create', as: :new_internal_code
  get 'indicators/health_ensurances_relation', to: 'indicators#health_ensurances_relation', as: :health_ensurances_relation
  get 'indicators/concluded_exams', to: 'indicators#concluded_exams', as: :concluded_exams
  get 'indicators/exams_per_field'
  get 'indicators/exams_in_progress', to: 'indicators#exams_in_progress', as: :exams_in_progress
  post 'backups/new', to: 'backups#create', as: :new_backup
  get 'backups/download/:id', to: 'backups#download', as: :backup_download
  get 'backups/index', to: 'backups#index', as: :backups
  get 'panels/exams'
  get 'panels/attendances'

  root 'home#index'
  get 'home_user/index'
  post 'home/longin', to: 'home#login'
  post 'home/logout', to: 'home#logout'
  get 'home_admin/index', to: 'home_admin#index'

  post 'users/:id/active', to: 'users#activate', as: :activate_user
  post 'users/:id/change_password', to: 'users#change_password', as: :change_password
  get 'users/:id/change_password', to: 'users#change_password_view', as: :change_password_view

  get 'attendance/:id/exams/new', to: 'exams#new', as: :new_exam
  post 'attendance/:id/exams/new', to: 'exams#create', as: :create_exam
  get 'exams/:id/edit', to: 'exams#edit', as: :edit_exam
  get 'exams/:id/start', to: 'exams#start', as: :start_exam
  patch 'exams/:id', to: 'exams#update', as: :update_exam
  patch 'exams/:id/initiate', to: 'exams#initiate', as: :initiate_exam
  patch 'exams/:id/completed', to: 'exams#completed', as: :change_to_completed
  patch 'exams/:id/change_exam_status', to: 'exams#change_exam_status', as: :change_exam_status

  get 'samples/new/attendance/:id', to: 'samples#new', as: :new_sample
  get 'subsamples/sample/:id/new', to: 'subsamples#new', as: :new_sub_sample

  get 'attendances/:id/workflow', to: 'attendances#workflow', as: :workflow
  get 'attendances/new/patient/:id', to: 'attendances#new', as: :new_attendance
  get 'attendances/lis_code', to: 'attendances#find_by_lis_code', as: :lis_search
  patch 'attendances/:id/report', to: 'attendances#add_report', as: :add_report

  get 'offered_exams/field/:id', to: 'offered_exams#exams_per_field', as: :exam_per_field
  post 'offered_exams/:id/activate', to: 'offered_exams#active_exam', as: :acitvate_offered_exam

  get 'patient/:id/attendances', to: 'attendances#attendances_from_patient', as: :attendances_from_patient

  resources :brands
  resources :reagents
  resources :work_maps
  resources :hospitals
  resources :subsamples
  resources :samples, except: [:new]
  resources :users
  resources :attendances, except: [:new]
  resources :offered_exams
  resources :patients, except: [:destroy]
  resources :subsamples
  resources :internal_codes, only: [:create, :destroy, :index]
end
