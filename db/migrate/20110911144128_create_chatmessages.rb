class CreateChatmessages < ActiveRecord::Migration[4.2]
  def change
    create_table :chatmessages do |t|
      t.string :by
      t.text :message

      t.timestamps
    end
  end
end
