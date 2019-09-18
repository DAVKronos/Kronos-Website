class AddCommissionToMailinglists < ActiveRecord::Migration[4.2]
  def change
    add_column :mailinglists, :commission_id, :integer
  end
end
