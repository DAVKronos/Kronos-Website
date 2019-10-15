class AddFolderToKronometers < ActiveRecord::Migration
  def change
	add_column :kronometers, :folder_id, :integer
  end
end
