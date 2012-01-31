class AddInternToAgendaitems < ActiveRecord::Migration
  def change
    add_column :agendaitems, :intern, :boolean
  end
end
