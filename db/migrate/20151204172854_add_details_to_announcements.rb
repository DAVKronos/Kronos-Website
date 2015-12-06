class AddDetailsToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :title, :text
    add_column :announcements, :url, :text
  end
end
