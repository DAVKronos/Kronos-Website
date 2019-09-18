class ChangeEvents2 < ActiveRecord::Migration[4.2]
  def change
    remove_column :events, :valide
  end
end
