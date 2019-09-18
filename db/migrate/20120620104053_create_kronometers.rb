class CreateKronometers < ActiveRecord::Migration[4.2]
  def change
    create_table :kronometers do |t|
      t.string :name
      t.date :date
      t.attachment :file
      

      t.timestamps
    end
  end
end
