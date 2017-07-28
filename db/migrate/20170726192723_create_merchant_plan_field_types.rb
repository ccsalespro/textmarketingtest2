class CreateMerchantPlanFieldTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :merchant_plan_field_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
