class AddRequestEnvToChatmessages < ActiveRecord::Migration[4.2]
  def change
    change_table :chatmessages do |t|
      t.string :user_ip
      t.string :user_agent
      t.string :referrer
    end
  end
end
