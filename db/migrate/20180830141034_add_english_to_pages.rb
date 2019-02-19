class AddEnglishToPages < ActiveRecord::Migration
  def change
	add_column :pages, :information_en, :string
	add_column :pages, :pagetag_en, :string
  end
end
