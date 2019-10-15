class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string   :name
      t.integer  :folder_id
    end
  end
end
