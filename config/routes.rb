Rails.application.routes.draw do
  get 'fish-api/exams', to: 'fish_api#exams', as: :fish_api_exams
  get 'fish-api/users', to: 'fish_api#users', as: :fish_api_users
  get 'indicators/repeated-exams', to: 'indicators#repeated_exams_report', as: :repeated_exams_report
  get 'indicators/global_production', to: 'indicators#global_production', as: :global_production
  get 'indicators/production_per_stand/:stand', to: 'indicators#production_per_stand', as: :production_per_stand
  get 'maintenance/maintenance', to: 'maintenance#maintenance', as: :maintenance
  get 'stock_products/reports/base-report', to: 'stock_products#base_report', as: :stock_products_base_report
  get '/status', to: 'home#status', as: :status
  get 'stock_outs', to: 'stock_outs#index', as: :stock_outs
  post 'stock_outs/create', to: 'stock_outs#create', as: :create_stock_out
  get 'stock_outs/product/:id', to: 'stock_outs#new', as: :new_stock_out
  resources :stock_products
  get "stock-entry/:id/tag", to: "stock_entries#display_new_tag", as: :display_new_tag
  resources :stock_entries
  patch "releases/confirm/:id", to: "releases#confirm", as: :check_release_message
  resources :releases
  get "indicators/response_time/:group", to: "indicators#response_time", as: :response_time
  patch "exams/:id/reopen", to: "exams#reopen_exam", as: :reopen_exam
  patch "exams/:id/remove-report", to: 'exams#remove_report', as: :remove_report
  patch 'exams/:id/partial_released', to: 'exams#change_to_partial_released', as: :partial_released
  get 'exams/:id/partial_released', to: 'exams#partial_released', as: :change_to_partial_released
  patch 'exams/:id/save_report', to: 'exams#save_exam_report', as: :save_exam_report
  get 'exams/:id/add_report', to: 'exams#add_report', as: :add_report_to_exam
  get 'indicators/health_ensurances_relation', to: 'indicators#health_ensurances_relation', as: :health_ensurances_relation
  get 'indicators/concluded_exams', to: 'indicators#concluded_exams', as: :concluded_exams
  get 'indicators/exams_in_progress', to: 'indicators#exams_in_progress', as: :exams_in_progress
  post 'backups/new', to: 'backups#create', as: :new_backup
  get 'backups/download/:id', to: 'backups#download', as: :backup_download
  get 'backups/index', to: 'backups#index', as: :backups

  # CODES
  get 'internal_codes/code/:code', to: 'internal_codes#show', as: :get_internal_code
  post 'internal_codes/new/:id', to: 'internal_codes#create', as: :new_internal_code


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
  patch 'attendances/:id/report', to: 'attendances#add_report', as: :add_report

  resources :products
  resources :suggestions
  resources :brands
  resources :work_maps
  resources :hospitals
  resources :subsamples
  resources :samples, except: [:new]
  resources :users, except: [:show]
  resources :attendances, except: [:new, :delete, :index, :edit]
  resources :offered_exams
  resources :patients, except: [:destroy]
  resources :subsamples
  resources :internal_codes, only: [:create, :destroy, :index]
end
