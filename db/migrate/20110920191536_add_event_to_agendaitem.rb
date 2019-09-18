class AddEventToAgendaitem < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :agendaitem_id, :integer
  end
end
