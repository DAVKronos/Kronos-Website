class AddMatchesToAgendaitemtype < ActiveRecord::Migration
  def change
    add_column :agendaitemtypes, :is_match, :boolean
  end
end
