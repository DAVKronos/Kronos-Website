class RemoveUseridFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :user_id
  end
end
