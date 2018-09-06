class RemoveEnglishToPages < ActiveRecord::Migration
  def change
	remove_column :pages, :information_en, :string 
  end
end
