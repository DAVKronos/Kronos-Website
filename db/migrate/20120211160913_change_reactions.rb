class ChangeReactions < ActiveRecord::Migration[4.2]
  def change
    remove_column :reactions, :reaction
    add_column :reactions, :reactiontext, :text
  end
end
