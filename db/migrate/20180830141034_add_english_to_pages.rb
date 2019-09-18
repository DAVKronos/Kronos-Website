class AddEnglishToPages < ActiveRecord::Migration[4.2]
  def change
	add_column :pages, :information_en, :string
	add_column :pages, :pagetag_en, :string
  end
end
