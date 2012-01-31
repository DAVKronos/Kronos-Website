class AddPhotosToPhotoalbums < ActiveRecord::Migration
  def change
    add_column :photos, :photoalbum_id, :integer
  end
end
