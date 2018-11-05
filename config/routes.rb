Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :attachments
  resources :projects do
  	resources :tickets
    resources :posts
  end
  resources :reports
  resources :tickets do
    resources :comments
  end
  resources :users, except: :create

  get 'projects/:id/remove_client' => 'projects#remove_client'
  get 'projects/:id/remove_employee' => 'projects#remove_employee'
  get 'projects/:id/dashboard' => 'projects#dashboard', :as => :dashboard
  get 'projects/:id/files' => 'projects#files', :as => :files
  get 'projects/:id/events' => 'projects#events', :as => :events
  get 'projects/:id/team' => 'projects#team', :as => :team
  get 'projects/:id/reports' => 'projects#reports', :as => :project_reports
  get 'projects/:id/message_board' => 'projects#message_board', :as => :message_board
  get 'projects/:id/clients' => 'projects#clients', :as => :clients
  get 'reports/:id/download' => 'reports#download'
  get 'tickets/:id/subtasks' => 'tickets#subtasks', :as => :subtasks
  get 'tickets/:id/bugs' => 'tickets#bugs', :as => :bugs
  get 'tickets/:id/comments' => 'tickets#comments', :as => :comments
  get 'tickets/:id/files' => 'tickets#files', :as => :ticket_files
  get 'users/:id/files' => 'users#files', :as => :user_files
  get 'users/:id/unread' => 'users#unread', :as => :unread
  get 'users/type' => 'users#custom_index', :as => :type
  get 'users/:id/remove_role' => 'users#remove_role'

  patch 'projects/:id/add_client' => 'projects#add_client'
  patch 'projects/:id/add_project_manager' => 'projects#add_project_manager'
  patch 'projects/:id/assign_dev' => 'tickets#assign_dev'
  patch 'projects/:id/add_dev' => 'projects#add_dev'
  patch 'projects/:id/add_tester' => 'projects#add_tester'
  patch 'projects/:id/add_employees' => 'projects#add_employees'
  patch 'projects/:id/add_files' => 'projects#add_files'
  patch 'reports/:id/change_availability' => 'reports#change_availability', :as => :change_availability
  patch 'tickets/:id/change_status' => 'tickets#change_status', :as => :change_status
  post 'tickets/undo' => 'tickets#undo', :as => :undo
  patch 'tickets/:id/add_files' => 'tickets#add_files'

  post 'create_user' => 'users#create', as: :create_user
end
