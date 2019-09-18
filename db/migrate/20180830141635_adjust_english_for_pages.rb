class AdjustEnglishForPages < ActiveRecord::Migration[4.2]
  def change
    Page.update_all pagetag_en: "Some Page"
	Page.update_all information_en: "English text not yet available"
  end
end
