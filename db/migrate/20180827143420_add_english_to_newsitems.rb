class AddEnglishToNewsitems < ActiveRecord::Migration[4.2]
  def change
    add_column :newsitems, :title_en, :string, :default => "News item"
	add_column :newsitems,  :news_en,  :text, :default => "English text not yet available"
  end
end
