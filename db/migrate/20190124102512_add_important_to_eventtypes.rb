class AddImportantToEventtypes < ActiveRecord::Migration[4.2]
  def change
	add_column :eventtypes, :important, :boolean
  end
end
