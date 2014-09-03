class AddRoleToCommission < ActiveRecord::Migration
  def change
    add_column :commissions, :role, :string
  end
end