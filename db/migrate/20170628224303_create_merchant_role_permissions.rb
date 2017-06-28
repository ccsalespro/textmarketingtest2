class CreateMerchantRolePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :merchant_role_permissions do |t|
      t.integer :merchant_role_id
      t.integer :merchant_permission_id

      t.timestamps
    end
  end
end
