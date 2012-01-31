class AddUserToNewsitems < ActiveRecord::Migration
  def change
    add_column :newsitems, :user_id, :integer
    add_column :newsitems, :agreed_by, :integer
  end
end
