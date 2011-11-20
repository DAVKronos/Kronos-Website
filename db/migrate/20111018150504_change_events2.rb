class ChangeEvents2 < ActiveRecord::Migration
  def change
    remove_column :events, :valide
  end
end
