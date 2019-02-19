class AdjustEnglishForNewsitems < ActiveRecord::Migration
  def change
    Newsitem.update_all title_en: "News item"
	Newsitem.update_all news_en: "English text not yet available"
  end
end
