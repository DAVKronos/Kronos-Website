class AddProcessingToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :processing, :boolean

  end
end
