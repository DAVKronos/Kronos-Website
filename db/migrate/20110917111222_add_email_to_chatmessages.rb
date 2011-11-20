class AddEmailToChatmessages < ActiveRecord::Migration
  def change
    add_column :chatmessages, :email, :string
  end
end
