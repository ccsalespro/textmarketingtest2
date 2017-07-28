class CreateCompanyCharges < ActiveRecord::Migration[5.1]
  def change
    create_table :company_charges do |t|
      t.decimal :amount
      t.integer :company_id

      t.timestamps
    end
  end
end
