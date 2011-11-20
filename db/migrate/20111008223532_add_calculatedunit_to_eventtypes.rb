class AddCalculatedunitToEventtypes < ActiveRecord::Migration
  def change
    add_column :eventtypes, :calculated_unit, :string
  end
end
