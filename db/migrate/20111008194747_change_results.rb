class ChangeResults < ActiveRecord::Migration
  def change
    change_column :results, :result, :string
  end
end
