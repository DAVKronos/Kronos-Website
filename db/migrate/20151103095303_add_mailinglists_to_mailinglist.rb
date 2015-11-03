class AddMailinglistsToMailinglist < ActiveRecord::Migration
  def change
    add_column :mailinglists, :mailinglist_id, :integer    
  end
end
