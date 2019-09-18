class CreateNewsitems < ActiveRecord::Migration[4.2]
  def change
    create_table :newsitems do |t|
      t.string :title
      t.text :news
      t.boolean :agreed

      t.timestamps
    end
  end
end
