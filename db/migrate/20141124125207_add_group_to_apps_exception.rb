class AddGroupToAppsException < ActiveRecord::Migration
  def change
    add_column :apps_exceptions, :group_email, :string
  end
end
