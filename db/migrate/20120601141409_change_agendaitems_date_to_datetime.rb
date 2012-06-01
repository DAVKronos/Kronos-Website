class ChangeAgendaitemsDateToDatetime < ActiveRecord::Migration
 def change
   change_column :agendaitems, :date, :date
 end
end
