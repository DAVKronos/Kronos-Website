class CreateAppsExceptions < ActiveRecord::Migration
  def change
    create_table :apps_exceptions do |t|
      t.string :email
      t.boolean :way

      t.timestamps
    end
  end
end
