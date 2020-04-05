class AddMaxsubscriptionToAgendaitems < ActiveRecord::Migration[4.2]
  def change
	add_column :agendaitems, :maxsubscription, :integer
  end
end
