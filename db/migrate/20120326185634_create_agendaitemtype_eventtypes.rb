class CreateAgendaitemtypeEventtypes < ActiveRecord::Migration
  def change
    create_table :agendaitemtype_eventtypes do |t|
      t.integer :agendaitemtype_id
      t.integer :eventtype_id

      t.timestamps
    end
  end
end
