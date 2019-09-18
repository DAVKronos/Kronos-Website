class AddProcessingToPhotos < ActiveRecord::Migration[4.2]
  def change
    add_column :photos, :processing, :boolean

  end
end
