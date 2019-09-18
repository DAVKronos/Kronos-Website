class AddPhonenumberToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :phonenumber, :string
  end
end
