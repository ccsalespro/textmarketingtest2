class AddCreatedByAndUpdatedByToTemplates < ActiveRecord::Migration[5.1]
  def change
    add_column :templates, :created_by, :integer
    add_column :templates, :last_updated_by, :integer
  end
end
