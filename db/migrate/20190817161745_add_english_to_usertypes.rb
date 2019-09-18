class AddEnglishToUsertypes < ActiveRecord::Migration[4.2]
  def change
	add_column :user_types, :name_en, :string
  end
end
