Rails.application.routes.draw do
  resources :merchant_permissions
  resources :company_permissions
  resources :merchant_roles
  resources :company_roles

  devise_for :admins
  devise_for :merchant_users
  devise_for :company_users

  resources :companies do
    get 'merchant_billing_plans/choose'
    get 'merchant_billing_plans/show_all_merchants'
    resources :merchant_billing_plans do
      resources :merchants do
        resources :merchant_plans
      end
    end
  end

  resources :merchants do
    resources :customers
    resources :messages, only: [:new, :create, :show, :index] do
      collection do
        post 'reply'
      end
    end
    resources :templates do
      collection do
        post 'publish'
      end
    end
  end

  resources :company_plans do
    resources :company_plan_fields
  end

  get 'dashboard/overview'
  get 'dashboard/landing_page'
  root 'dashboard#landing_page'

  get 'company_users/new_company_user'
  post 'company_users/create_company_user'
  resources :company_users, only: [:index, :edit, :update, :show]
  delete 'company_users/destroy_company_user'

  post 'company_roles/add_permission'
  post 'company_roles/remove_permission'


  get 'merchant_users/new_merchant_user'
  post 'merchant_users/create_merchant_user'
  resources :merchant_users, only: [:index, :edit, :update]
  delete 'merchant_users/destroy_merchant_user'

  post 'merchant_roles/add_permission'
  post 'merchant_roles/remove_permission'
end