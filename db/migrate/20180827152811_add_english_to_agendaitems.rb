class AddEnglishToAgendaitems < ActiveRecord::Migration
  def change
	add_column :agendaitems, :name_en, :string, :default => "Agenda item"
	add_column :agendaitems,  :description_en,  :text, :default => "English description not yet available"
  end
end
