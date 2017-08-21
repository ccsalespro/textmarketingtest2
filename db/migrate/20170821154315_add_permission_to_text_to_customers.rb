class AddPermissionToTextToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :permission_to_text, :boolean, default: false
  end
end
