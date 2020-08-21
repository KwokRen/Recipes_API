class AddReferenceToCategory < ActiveRecord::Migration[6.0]
  def change
    change_table :categories do |t|
      t.belongs_to :user, null:false, foreign_key: true
    end
  end
end
