class AddInternToAgendaitems < ActiveRecord::Migration[4.2]
  def change
    add_column :agendaitems, :intern, :boolean
  end
end
