class CreateMerchantPermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :merchant_permissions do |t|
      t.string :name

      t.timestamps
    end
  end
end
