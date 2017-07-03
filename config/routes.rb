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

  get 'company_users/new_company_user'
  post 'company_users/create_company_user'

  get 'dashboard/overview'
  root 'dashboard#overview'
end
