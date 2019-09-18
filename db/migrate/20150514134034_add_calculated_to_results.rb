class AddCalculatedToResults < ActiveRecord::Migration[4.2]
  def change
    add_column :results, :calculated, :decimal
  end
end
