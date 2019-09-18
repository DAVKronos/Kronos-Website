class ChangeAgendaitems < ActiveRecord::Migration[4.2]
  def change
    change_column :agendaitems, :description, :text
  end
end
