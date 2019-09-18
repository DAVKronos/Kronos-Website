class ChangeAgendaitemsDateToDatetime < ActiveRecord::Migration[4.2]
 def change
   change_column :agendaitems, :date, :date
 end
end
