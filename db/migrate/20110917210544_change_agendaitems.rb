class ChangeAgendaitems < ActiveRecord::Migration
  def change
    change_column :agendaitems, :description, :text
  end
end
