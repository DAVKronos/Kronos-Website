class AddEnglishToAgendaitemtypes < ActiveRecord::Migration[4.2]
  def change
	add_column :agendaitemtypes, :name_en, :string
  end
end
