class CreateCompanyPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :company_plans do |t|
      t.integer :company_id
      t.string :name

      t.timestamps
    end
  end
end
