class AddInfoToPages < ActiveRecord::Migration[4.2]
  def change
	add_column :pages, :information_en, :text
  end
end
