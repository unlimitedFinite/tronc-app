Rails.application.routes.draw do
  resources :tronc_records
  resources :employee_records
  resources :employees
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
