class AddMoreToReactions < ActiveRecord::Migration[4.2]
  def change
    add_column :reactions, :user_id, :integer
    add_column :reactions, :agendaitem_id, :integer
    add_column :reactions, :result_id, :integer
    add_column :reactions, :photo_id, :integer
    add_column :reactions, :newsitem_id, :integer
  end
end
