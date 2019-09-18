class AdjustEnglishForAgendaitemtypes < ActiveRecord::Migration[4.2]
  def change
    Agendaitemtype.update_all name_en: "English Name"
  end
end
