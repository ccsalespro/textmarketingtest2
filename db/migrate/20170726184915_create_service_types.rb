class CreateServiceTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :service_types do |t|
      t.integer :company_id

      t.timestamps
    end
  end
end
