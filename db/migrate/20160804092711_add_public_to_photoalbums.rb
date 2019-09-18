class AddPublicToPhotoalbums < ActiveRecord::Migration[4.2]
  def change
    add_column :photoalbums, :public, :boolean
  end
end
