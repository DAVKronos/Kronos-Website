class AddLocalPartToMailinglists < ActiveRecord::Migration[4.2]
  def change
    add_column :mailinglists, :local_part, :string
  end
end
