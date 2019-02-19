class AddImportantToEventtypes < ActiveRecord::Migration
  def change
	add_column :eventtypes, :important, :boolean
  end
end
