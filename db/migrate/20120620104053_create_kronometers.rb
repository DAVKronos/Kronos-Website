class CreateKronometers < ActiveRecord::Migration
  def change
    create_table :kronometers do |t|
      t.string :name
      t.date :date
      t.attachment :file
      

      t.timestamps
    end
  end
end
