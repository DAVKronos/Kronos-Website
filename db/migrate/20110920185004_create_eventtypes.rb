class CreateEventtypes < ActiveRecord::Migration
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
