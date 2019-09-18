class AddEventtypeToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :eventtype_id, :integer
  end
end
