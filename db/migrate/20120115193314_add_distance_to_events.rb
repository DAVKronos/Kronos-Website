class AddDistanceToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :distance, :float
  end
end
