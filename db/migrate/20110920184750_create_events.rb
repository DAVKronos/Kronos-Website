class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :date

      t.timestamps
    end
  end
end
