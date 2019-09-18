class AddVideosToPhotos < ActiveRecord::Migration[4.2]
  def change
    add_column :photos, :youtube_id, :string
  end
end
