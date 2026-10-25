class CreateFoodEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :food_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :meal_type
      t.string :food_name
      t.string :food_group
      t.string :quantity
      t.date :eaten_on

      t.timestamps
    end
  end
end
