class AdjustEnglishForAgendaitemtypes < ActiveRecord::Migration
  def change
    Agendaitemtype.update_all name_en: "English Name"
  end
end
