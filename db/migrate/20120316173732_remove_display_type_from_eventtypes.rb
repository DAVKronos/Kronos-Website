class RemoveDisplayTypeFromEventtypes < ActiveRecord::Migration[4.2]
 def change
   remove_column :eventtypes, :display_type
   rename_column :eventtypes, :calculation, :formula
 end
end
