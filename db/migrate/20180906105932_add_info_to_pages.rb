class AddInfoToPages < ActiveRecord::Migration
  def change
	add_column :pages, :information_en, :text
  end
end
