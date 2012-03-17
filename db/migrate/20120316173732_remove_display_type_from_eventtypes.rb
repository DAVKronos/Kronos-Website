class RemoveDisplayTypeFromEventtypes < ActiveRecord::Migration
 def change
   remove_column :eventtypes, :display_type
   rename_column :eventtypes, :calculation, :formula
 end
end
