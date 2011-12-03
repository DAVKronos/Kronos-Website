class AddIndexesToCommissionMemberships < ActiveRecord::Migration
  def change
    add_index :commission_memberships, :user_id, :name => 'user_id_ix'
    add_index :commission_memberships, :commission_id, :name => 'commission_id_ix'
  end
end
