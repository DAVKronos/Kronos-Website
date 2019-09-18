class AddCalculatedunitToEventtypes < ActiveRecord::Migration[4.2]
  def change
    add_column :eventtypes, :calculated_unit, :string
  end
end
