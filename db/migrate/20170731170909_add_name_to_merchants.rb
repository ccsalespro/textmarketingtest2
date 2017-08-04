class AddNameToMerchants < ActiveRecord::Migration[5.1]
  def change
    add_column :merchants, :name, :string
  end
end
