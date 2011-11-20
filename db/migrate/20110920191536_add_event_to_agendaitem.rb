class AddEventToAgendaitem < ActiveRecord::Migration
  def change
    add_column :events, :agendaitem_id, :integer
  end
end
