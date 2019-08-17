class AddEnglishToUsertypes < ActiveRecord::Migration
  def change
	add_column :user_types, :name_en, :string
  end
end
