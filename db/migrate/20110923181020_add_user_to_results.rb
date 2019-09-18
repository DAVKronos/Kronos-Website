class AddUserToResults < ActiveRecord::Migration[4.2]
  def change
    add_column :results, :user_id, :integer
  end
end
