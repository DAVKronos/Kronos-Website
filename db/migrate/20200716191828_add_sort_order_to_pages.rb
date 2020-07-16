class AddSortOrderToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :sort_order, :integer
  end
end
