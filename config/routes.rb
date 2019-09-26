Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  get 'pages/example'
  get 'reports/setup', to: 'reports#setup', as: :setup_path
  resources :reports
  resources :tronc_records
  resources :employees
  root to: 'reports#index'
  get 'reports/print_pdf', to: 'reports#print_pdf'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
