class AddPhotosToPhotoalbums < ActiveRecord::Migration[4.2]
  def change
    add_column :photos, :photoalbum_id, :integer
  end
end
