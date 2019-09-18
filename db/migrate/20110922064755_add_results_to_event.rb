class AddResultsToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :results, :event_id, :integer
  end
end
