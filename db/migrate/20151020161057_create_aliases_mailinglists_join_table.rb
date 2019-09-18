class CreateAliasesMailinglistsJoinTable < ActiveRecord::Migration[4.2]
  def change
    create_table :aliases_mailinglists, :id => false do |t|
      t.integer :alias_id
      t.integer :mailinglist_id
    end

    add_index :aliases_mailinglists, [:alias_id, :mailinglist_id]
  end
end
