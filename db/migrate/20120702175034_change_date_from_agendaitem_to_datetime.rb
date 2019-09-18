class ChangeDateFromAgendaitemToDatetime < ActiveRecord::Migration[4.2]
  def change
    change_column :agendaitems, :date, :datetime  
  end
end
