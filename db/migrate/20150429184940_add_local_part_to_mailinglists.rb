class AddLocalPartToMailinglists < ActiveRecord::Migration
  def change
    add_column :mailinglists, :local_part, :string
  end
end
