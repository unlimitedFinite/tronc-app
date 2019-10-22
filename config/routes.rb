Rails.application.routes.draw do
  devise_for :users, :skip => [ :registrations, :passwords ]
  devise_scope :user do
    get 'users/sign_up', to: 'users/registrations#new', as: :new_user_registration
    post 'users/sign_up', to: 'users/registrations#create', as: :user_registration
    get 'users/password', to: 'users/passwords#new', as: :new_user_password
    post 'users/password', to: 'users/passwords#create', as: :user_password
    get 'users/password/edit', to: 'users/passwords#edit', as: :edit_user_password
    put 'users/password', to: 'users/passwords#update'
  end
  get 'reports/setup', to: 'reports#setup', as: :setup_path
  get 'reports/print_pdf', to: 'reports#print_pdf'
  get 'tronc_records/employees', to: 'tronc_records#new_employees', as: :new_employees_records
  get 'users/confirm', to: 'users#confirm', as: :confirm_path
  resources :reports, except: [:edit]
  resources :tronc_records
  resources :employee_records
  resources :employees, only: [:index, :new, :create, :edit, :update]
  root to: 'reports#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
