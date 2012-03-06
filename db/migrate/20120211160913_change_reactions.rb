class ChangeReactions < ActiveRecord::Migration
  def change
    remove_column :reactions, :reaction
    add_column :reactions, :reactiontext, :text
  end
end
