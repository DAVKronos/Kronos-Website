class AddExifDateToPhotos < ActiveRecord::Migration[4.2]
  def change
    add_column :photos, :exif_date, :datetime
  end
end
