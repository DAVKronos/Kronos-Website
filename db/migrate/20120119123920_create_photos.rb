class CreatePhotos < ActiveRecord::Migration[4.2]
  def change
    create_table :photos do |t|
      t.string :caption

      t.timestamps
    end
  end
end
