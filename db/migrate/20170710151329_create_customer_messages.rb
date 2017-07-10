class CreateCustomerMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_messages do |t|
      t.integer :customer_id
      t.integer :message_id

      t.timestamps
    end
  end
end
