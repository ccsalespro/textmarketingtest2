class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.string :subdomain

      t.timestamps
    end
  end
end
