class AddAgendaitemtypeToAgendaitem < ActiveRecord::Migration
  def change
    add_column :agendaitems, :agendaitemtype_id, :integer
  end
end
