class AddConstraintsToEventtypes < ActiveRecord::Migration
  def change
    add_column :eventtypes, :display_weg, :boolean
    add_column :eventtypes, :display_cross, :boolean
    add_column :eventtypes, :display_borrel, :boolean
    add_column :eventtypes, :display_activiteit, :boolean
    add_column :eventtypes, :display_indoor, :boolean
    add_column :eventtypes, :display_baan, :boolean
  end
end
