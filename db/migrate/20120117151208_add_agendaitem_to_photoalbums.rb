class AddAgendaitemToPhotoalbums < ActiveRecord::Migration[4.2]
  def change
    add_column :photoalbums, :agendaitem_id, :integer
  end
end
