class AddDetailsToAnnouncements < ActiveRecord::Migration[4.2]
  def change
    add_column :announcements, :title, :text
    add_column :announcements, :url, :text
  end
end
