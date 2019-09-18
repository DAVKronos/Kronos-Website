class AddStudieinfoToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :studie, :string
    add_column :users, :instelling, :string
    add_column :users, :aanvang, :integer
  end
end
