class AddRoleToCommission < ActiveRecord::Migration[4.2]
  def change
    add_column :commissions, :role, :string
  end
end