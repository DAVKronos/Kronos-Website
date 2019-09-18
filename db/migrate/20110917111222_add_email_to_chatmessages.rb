class AddEmailToChatmessages < ActiveRecord::Migration[4.2]
  def change
    add_column :chatmessages, :email, :string
  end
end
