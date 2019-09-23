Rails.application.routes.draw do
  get 'pages/example'
  resources :reports
  resources :tronc_records
  resources :employees
  root to: 'reports#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
