class RemoveUseridFromPages < ActiveRecord::Migration[4.2]
  def change
    remove_column :pages, :user_id
  end
end
