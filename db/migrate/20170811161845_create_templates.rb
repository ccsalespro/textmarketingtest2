class CreateTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :templates do |t|
      t.string :subject
      t.text :body
      t.integer :merchant_id

      t.timestamps
    end
  end
end
