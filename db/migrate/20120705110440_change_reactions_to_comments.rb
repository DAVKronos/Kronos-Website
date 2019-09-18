class ChangeReactionsToComments < ActiveRecord::Migration[4.2]
  def change
    rename_table :reactions, :comments
    change_table :comments do |t|
      t.rename :reactiontext, :commenttext
      t.references :commentable, :polymorphic => true
    end
  end
end
