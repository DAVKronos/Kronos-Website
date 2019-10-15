class CreateFolders < ActiveRecord::Migration[4.2]
  def change
    create_table :folders do |t|
      t.string   :name
      t.integer  :folder_id
    end
  end
end
