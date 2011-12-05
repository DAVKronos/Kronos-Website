class CreateChangedUsers < ActiveRecord::Migration
  def change
    create_table :changed_users do |t|

      t.timestamps
    end
  end
end
