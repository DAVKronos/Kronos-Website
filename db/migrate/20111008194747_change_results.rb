class ChangeResults < ActiveRecord::Migration[4.2]
  def change
    change_column :results, :result, :string
  end
end
