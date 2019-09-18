class RemoveEnglishToPages < ActiveRecord::Migration[4.2]
  def change
	remove_column :pages, :information_en 
  end
end
