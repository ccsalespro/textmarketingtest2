class CreateCompanyPermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :company_permissions do |t|
      t.string :name

      t.timestamps
    end
  end
end
