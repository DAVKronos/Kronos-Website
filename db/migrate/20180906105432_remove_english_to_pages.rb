class RemoveEnglishToPages < ActiveRecord::Migration
  def change
	remove_column :pages, :information_en 
  end
end
