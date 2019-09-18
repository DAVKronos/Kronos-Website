class CreateEventtypes < ActiveRecord::Migration[4.2]
  def change
    create_table :eventtypes do |t|
      t.string :name
      t.string :calculation
      t.string :shortname
      t.string :measuringunit

      t.timestamps
    end
  end
end
