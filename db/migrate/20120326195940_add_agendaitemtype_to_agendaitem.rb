class AddAgendaitemtypeToAgendaitem < ActiveRecord::Migration[4.2]
  def change
    add_column :agendaitems, :agendaitemtype_id, :integer
  end
end
