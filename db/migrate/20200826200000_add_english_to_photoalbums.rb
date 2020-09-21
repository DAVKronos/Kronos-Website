class AddEnglishToPhotoalbums < ActiveRecord::Migration[5.0]
  def change
	add_column :photoalbums, :name_en, :string
  end
end
