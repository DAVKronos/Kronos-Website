class AdjustEnglishForAgendaitems < ActiveRecord::Migration[4.2]
  def change
    Agendaitem.update_all name_en: "Agenda item"
	Agendaitem.update_all description_en: "English description not yet available"
  end
end
