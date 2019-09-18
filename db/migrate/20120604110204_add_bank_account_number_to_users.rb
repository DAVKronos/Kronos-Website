class AddBankAccountNumberToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :bank_account_number, :string
  end
end
