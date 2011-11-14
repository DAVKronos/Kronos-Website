class AddEventtypeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :eventtype_id, :integer
  end
end
