class AddMatchesToAgendaitemtype < ActiveRecord::Migration[4.2]
  def change
    add_column :agendaitemtypes, :is_match, :boolean
  end
end
