class AddVideosToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :youtube_id, :string
  end
end
