class CreateCompanyRolePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :company_role_permissions do |t|
      t.integer :company_role_id
      t.integer :company_permission_id

      t.timestamps
    end
  end
end
