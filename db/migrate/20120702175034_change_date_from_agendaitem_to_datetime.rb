class ChangeDateFromAgendaitemToDatetime < ActiveRecord::Migration
  def change
    change_column :agendaitems, :date, :datetime  
  end
end
