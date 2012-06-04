class AddXtracardToUsers < ActiveRecord::Migration
  def change
    add_column :users, :xtracard, :string
  end
end
