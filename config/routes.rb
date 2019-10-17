Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  get 'reports/setup', to: 'reports#setup', as: :setup_path
  get 'reports/print_pdf', to: 'reports#print_pdf'
  get 'tronc_records/employees', to: 'tronc_records#new_employees', as: :new_employees_records
  resources :reports, except: [:edit]
  resources :tronc_records
  resources :employee_records
  resources :employees, only: [:index, :new, :create, :edit, :update]
  root to: 'reports#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
