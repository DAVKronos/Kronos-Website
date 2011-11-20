class AddMatchToAgendaitems < ActiveRecord::Migration
  def change
    add_column :agendaitems, :category, :string
  end
end
