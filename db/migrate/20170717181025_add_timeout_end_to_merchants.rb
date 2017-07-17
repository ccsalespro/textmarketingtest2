class AddTimeoutEndToMerchants < ActiveRecord::Migration[5.1]
  def change
    add_column :merchants, :timeout_end, :string, default: Time.now
  end
end
