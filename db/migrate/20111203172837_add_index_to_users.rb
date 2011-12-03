class AddIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :id, :name => 'id_ix'
  end
end
