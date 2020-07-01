class AddEventdateToPhotoalbums < ActiveRecord::Migration[5.0]
  def change
    add_column :photoalbums, :eventdate, :datetime
  end
end
