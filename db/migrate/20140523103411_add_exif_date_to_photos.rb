class AddExifDateToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :exif_date, :datetime
  end
end
