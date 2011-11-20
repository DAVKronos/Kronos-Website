class AddValidToEvent < ActiveRecord::Migration
  def change
    add_column :events, :valide, :boolean
  end
end
