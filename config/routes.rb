Rails.application.routes.draw do
  get 'fish-api/exams', to: 'fish_api#exams', as: :fish_api_exams
  get 'fish-api/users', to: 'fish_api#users', as: :fish_api_users
  get 'maintenance/maintenance', to: 'maintenance#maintenance', as: :maintenance
  get '/status', to: 'home#status', as: :status

  #INDICATORS
  get 'indicators/repeated-exams', to: 'indicators#repeated_exams_report', as: :repeated_exams_report
  get 'indicators/global_production', to: 'indicators#global_production', as: :global_production
  get 'indicators/production_per_stand/:stand', to: 'indicators#production_per_stand', as: :production_per_stand
  get "indicators/response_time/:group", to: "indicators#response_time", as: :response_time
  get 'indicators/health_ensurances_relation', to: 'indicators#health_ensurances_relation', as: :health_ensurances_relation
  get 'indicators/concluded_exams', to: 'indicators#concluded_exams', as: :concluded_exams
  get 'indicators/exams_in_progress', to: 'indicators#exams_in_progress', as: :exams_in_progress

  # STOCK
  get 'stock_products/reports/base-report', to: 'stock_products#base_report', as: :stock_products_base_report
  resources :stock_products
  
  # EXAMS
  patch "exams/:id/reopen", to: "exams#reopen_exam", as: :reopen_exam
  patch "exams/:id/remove-report", to: 'exams#remove_report', as: :remove_report
  patch 'exams/:id/partial_released', to: 'exams#change_to_partial_released', as: :partial_released
  get 'exams/:id/partial_released', to: 'exams#partial_released', as: :change_to_partial_released
  patch 'exams/:id/save_report', to: 'exams#save_exam_report', as: :save_exam_report
  get 'exams/:id/add_report', to: 'exams#add_report', as: :add_report_to_exam
  patch 'exams/:id', to: 'exams#update', as: :update_exam
  patch 'exams/:id/initiate', to: 'exams#initiate', as: :initiate_exam
  patch 'exams/:id/completed', to: 'exams#completed', as: :change_to_completed
  patch 'exams/:id/change_exam_status', to: 'exams#change_exam_status', as: :change_exam_status
  get 'exams/:id/edit', to: 'exams#edit', as: :edit_exam
  get 'exams/:id/start', to: 'exams#start', as: :start_exam

  #ATTENDANCE
  get 'attendances/:id/workflow', to: 'attendances#workflow', as: :workflow
  get 'attendances/new/patient/:id', to: 'attendances#new', as: :new_attendance
  patch 'attendances/:id/report', to: 'attendances#add_report', as: :add_report
  get 'attendance/:id/exams/new', to: 'exams#new', as: :new_exam
  post 'attendance/:id/exams/new', to: 'exams#create', as: :create_exam

  root 'home#index'
  post 'home/longin', to: 'home#login'
  post 'home/logout', to: 'home#logout'
  get 'home', to: 'home#logged_in', as: :home
  resources :brands
  resources :samples
  resources :releases
  resources :products
  resources :hospitals
  resources :work_maps
  resources :subsamples
  resources :suggestions
  resources :offered_exams
  resources :stock_entries
  resources :users, except: [:show]
  resources :patients, except: [:destroy]
  resources :backups, only: [:index, :show, :create]
  resources :stock_outs, only: [:index, :new, :create]
  resources :internal_codes, only: [:create, :destroy, :index]
  resources :attendances, except: [:new, :delete, :index, :edit]
end
