class ChangeEvents3 < ActiveRecord::Migration[4.2]
  def change
    remove_column :eventtypes, :display_weg
    remove_column :eventtypes, :display_cross
    remove_column :eventtypes, :display_borrel
    remove_column :eventtypes, :display_activiteit
    remove_column :eventtypes, :display_indoor
    remove_column :eventtypes, :display_baan
    add_column :eventtypes, :display_type, :string
  end
end
