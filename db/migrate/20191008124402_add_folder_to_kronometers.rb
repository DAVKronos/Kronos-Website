class AddFolderToKronometers < ActiveRecord::Migration[4.2]
  def change
	add_column :kronometers, :folder_id, :integer
  end
end
