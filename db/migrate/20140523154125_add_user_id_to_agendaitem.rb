class AddUserIdToAgendaitem < ActiveRecord::Migration
  def change
    add_column :agendaitems, :user_id, :integer
  end
end
