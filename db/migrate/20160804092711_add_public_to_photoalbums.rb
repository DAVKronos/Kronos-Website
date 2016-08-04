class AddPublicToPhotoalbums < ActiveRecord::Migration
  def change
    add_column :photoalbums, :public, :boolean
  end
end
