class AddArticlephotoToNewsitems < ActiveRecord::Migration
  def change
    add_column :newsitems, :articlephoto_file_name, :string
    add_column :newsitems, :articlephoto_content_type, :string
    add_column :newsitems, :articlephoto_file_size, :integer
    add_column :newsitems, :articlephoto_updated_at, :datetime
  end
end

