class CreateAgendaitemtypeEventtypes < ActiveRecord::Migration[4.2]
  def change
    create_table :agendaitemtype_eventtypes do |t|
      t.integer :agendaitemtype_id
      t.integer :eventtype_id

      t.timestamps
    end
  end
end
