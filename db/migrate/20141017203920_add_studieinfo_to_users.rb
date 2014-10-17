class AddStudieinfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :studie, :string
    add_column :users, :instelling, :string
    add_column :users, :aanvang, :integer
  end
end
