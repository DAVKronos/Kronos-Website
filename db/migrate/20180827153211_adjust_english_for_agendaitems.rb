class AdjustEnglishForAgendaitems < ActiveRecord::Migration
  def change
    Agendaitem.update_all name_en: "Agenda item"
	Agendaitem.update_all description_en: "English description not yet available"
  end
end
