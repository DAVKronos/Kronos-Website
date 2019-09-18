class CreateReactions < ActiveRecord::Migration[4.2]
  def change
    create_table :reactions do |t|
      t.text :reaction

      t.timestamps
    end
  end
end
