class CreateCommissionMemberships < ActiveRecord::Migration
  def self.up
    create_table :commission_memberships do |t|
      t.string :function
      t.boolean :installed
      t.references :user
      t.references :commission

      t.timestamps
    end
  end

  def self.down
    drop_table :commission_memberships
  end
end
