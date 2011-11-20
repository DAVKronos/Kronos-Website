class AddResultsToEvent < ActiveRecord::Migration
  def change
    add_column :results, :event_id, :integer
  end
end
