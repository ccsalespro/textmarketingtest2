class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.string :subdomain
      t.integer :company_id

      t.timestamps
    end
  end
end
