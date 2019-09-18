class CreateAgendaitemtypes < ActiveRecord::Migration[4.2]
  def change
    create_table :agendaitemtypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
