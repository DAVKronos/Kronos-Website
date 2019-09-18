class AddMailinglistsToMailinglist < ActiveRecord::Migration[4.2]
  def change
    add_column :mailinglists, :mailinglist_id, :integer    
  end
end
