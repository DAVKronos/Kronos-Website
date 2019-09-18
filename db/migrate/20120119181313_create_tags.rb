class CreateTags < ActiveRecord::Migration[4.2]
  def change
    create_table :tags do |t|
      t.integer :photo_id
      t.integer :user_id
      t.integer :xpos
      t.integer :ypos
      t.integer :width
      t.integer :heigth

      t.timestamps
    end
  end
end
