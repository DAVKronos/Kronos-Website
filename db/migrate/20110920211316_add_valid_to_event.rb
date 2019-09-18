class AddValidToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :valide, :boolean
  end
end
