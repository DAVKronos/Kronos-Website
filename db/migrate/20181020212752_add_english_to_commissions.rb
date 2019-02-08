class AddEnglishToCommissions < ActiveRecord::Migration
  def change
	add_column :commissions, :name_en, :string
	add_column :commissions, :description_en, :text
  end
end
