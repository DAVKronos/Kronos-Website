class AddEnglishToCommissions < ActiveRecord::Migration[4.2]
  def change
	add_column :commissions, :name_en, :string
	add_column :commissions, :description_en, :text
  end
end
