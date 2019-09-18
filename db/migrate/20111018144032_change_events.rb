class ChangeEvents < ActiveRecord::Migration[4.2]
  def change
    change_column :events, :date, :time
  end
end
