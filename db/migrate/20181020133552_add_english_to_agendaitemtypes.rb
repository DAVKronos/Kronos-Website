class AddEnglishToAgendaitemtypes < ActiveRecord::Migration
  def change
	add_column :agendaitemtypes, :name_en, :string
  end
end
