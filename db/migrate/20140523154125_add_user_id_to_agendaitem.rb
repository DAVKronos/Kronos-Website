class AddUserIdToAgendaitem < ActiveRecord::Migration[4.2]
  def change
    add_column :agendaitems, :user_id, :integer
  end
end
