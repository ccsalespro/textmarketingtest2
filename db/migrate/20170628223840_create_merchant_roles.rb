class CreateMerchantRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :merchant_roles do |t|
      t.string :name
      t.integer :merchant_id

      t.timestamps
    end
  end
end
