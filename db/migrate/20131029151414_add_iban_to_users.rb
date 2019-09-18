class AddIbanToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :iban, :string
  end
end
