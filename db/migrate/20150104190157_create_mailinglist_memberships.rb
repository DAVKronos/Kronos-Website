class CreateMailinglistMemberships < ActiveRecord::Migration
  def change
    create_table :mailinglist_memberships do |t|
      t.references :user
      t.references :mailinglist

      t.timestamps
    end
    add_index :mailinglist_memberships, :user_id
    add_index :mailinglist_memberships, :mailinglist_id
  end
end
