class AddRequestEnvToChatmessages < ActiveRecord::Migration
  def change
    change_table :chatmessages do |t|
      t.string :user_ip
      t.string :user_agent
      t.string :referrer
    end
  end
end
