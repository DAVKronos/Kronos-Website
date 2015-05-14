class AddCalculatedToResults < ActiveRecord::Migration
  def change
    add_column :results, :calculated, :decimal
  end
end
