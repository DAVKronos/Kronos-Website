class CreateUserSessions < ActiveRecord::Migration[4.2]
  def self.up
    create_table :user_sessions do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :user_sessions
  end
end
