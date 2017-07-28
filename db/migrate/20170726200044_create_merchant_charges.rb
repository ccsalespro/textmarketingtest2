class CreateMerchantCharges < ActiveRecord::Migration[5.1]
  def change
    create_table :merchant_charges do |t|
      t.decimal :amount
      t.integer :merchant_id

      t.timestamps
    end
  end
end
