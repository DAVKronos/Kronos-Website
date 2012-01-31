class AddAgendaitemToPhotoalbums < ActiveRecord::Migration
  def change
    add_column :photoalbums, :agendaitem_id, :integer
  end
end
