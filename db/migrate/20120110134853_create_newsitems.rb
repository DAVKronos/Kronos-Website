class CreateNewsitems < ActiveRecord::Migration
  def change
    create_table :newsitems do |t|
      t.string :title
      t.text :news
      t.boolean :agreed

      t.timestamps
    end
  end
end
