class ChangeEvents < ActiveRecord::Migration
  def change
    change_column :events, :date, :time
  end
end
