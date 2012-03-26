class CreateAgendaitemtypes < ActiveRecord::Migration
  def change
    create_table :agendaitemtypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
