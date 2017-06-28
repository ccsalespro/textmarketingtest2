Rails.application.routes.draw do
  resources :merchant_permissions
  resources :company_permissions
  resources :merchant_roles
  resources :company_roles
  devise_for :admins
  devise_for :merchant_users
  devise_for :company_users
  resources :merchants
  resources :companies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
