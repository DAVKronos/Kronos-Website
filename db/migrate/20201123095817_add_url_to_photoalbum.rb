class AddUrlToPhotoalbum < ActiveRecord::Migration[5.2]
  def change
    add_column :photoalbums, :url, :string
  end
end
