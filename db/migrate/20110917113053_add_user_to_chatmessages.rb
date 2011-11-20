class AddUserToChatmessages < ActiveRecord::Migration
  def change
    add_column :chatmessages, :user_id, :integer
  end
end
