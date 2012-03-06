class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.text :reaction

      t.timestamps
    end
  end
end
