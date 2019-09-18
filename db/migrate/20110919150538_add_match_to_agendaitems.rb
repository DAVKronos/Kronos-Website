class AddMatchToAgendaitems < ActiveRecord::Migration[4.2]
  def change
    add_column :agendaitems, :category, :string
  end
end
