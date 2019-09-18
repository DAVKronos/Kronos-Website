class AddUserToNewsitems < ActiveRecord::Migration[4.2]
  def change
    add_column :newsitems, :user_id, :integer
    add_column :newsitems, :agreed_by, :integer
  end
end
