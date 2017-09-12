Rails.application.routes.draw do
  
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
  resources :company_permissions
  resources :company_plans do
    resources :company_plan_fields
  end
  resources :company_roles
  resources :merchants do
    resources :customers
    resources :messages, only: [:new, :create, :index]
    resources :templates do
      collection do
        post 'publish'
      end
    end
  end
  resources :company_users, only: [:index, :edit, :update, :show]
  resources :merchant_permissions
  resources :merchant_roles
  resources :merchant_users, only: [:index, :edit, :update]

  delete 'company_users/destroy_company_user'
  delete 'merchant_users/destroy_merchant_user'
  get 'company_users/new_company_user'
  get 'dashboard/landing_page'
  get 'dashboard/overview'
  get 'merchant_users/new_merchant_user'
  post 'company_roles/add_permission'
  post 'company_roles/remove_permission'
  post 'company_users/create_company_user'
  post 'merchant_roles/add_permission'
  post 'merchant_roles/remove_permission'
  post 'merchant_users/create_merchant_user'
  post 'messages/reply'
  root 'dashboard#landing_page'
end