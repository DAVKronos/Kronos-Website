class RemoveAdminFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :admin
      end

  def down
    add_column :users, :admin, :boolean
  end
end
