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

  get 'dashboard/overview'
  root 'dashboard#overview'

  get 'company_users/new_company_user'
  post 'company_users/create_company_user'
  resources :company_users, only: [:edit, :update]
  delete 'company_users/destroy_company_user'

  post 'company_roles/add_permission'
  post 'company_roles/remove_permission'


  get 'merchant_users/new_merchant_user'
  post 'merchant_users/create_merchant_user'
  resources :merchant_users, only: [:edit, :update]
  delete 'merchant_users/destroy_merchant_user'

  post 'merchant_roles/add_permission'
  post 'merchant_roles/remove_permission'
end