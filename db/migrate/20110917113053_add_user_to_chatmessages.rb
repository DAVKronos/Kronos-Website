class AddUserToChatmessages < ActiveRecord::Migration[4.2]
  def change
    add_column :chatmessages, :user_id, :integer
  end
end
