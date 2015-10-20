class AddCommissionToMailinglists < ActiveRecord::Migration
  def change
    add_column :mailinglists, :commission_id, :integer
  end
end
