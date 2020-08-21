class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :ingredients
      t.text :directions
      t.string :notes
      t.string :tags
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
