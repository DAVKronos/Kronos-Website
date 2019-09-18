class AdjustEnglishForCommissions < ActiveRecord::Migration[4.2]
  def change
    Commission.update_all name_en: "Commission name"
	Commission.update_all description_en: "English description"
  end
end
