class AdjustEnglishForPages < ActiveRecord::Migration
  def change
    Page.update_all pagetag_en: "Some Page"
	Page.update_all information_en: "English text not yet available"
  end
end
