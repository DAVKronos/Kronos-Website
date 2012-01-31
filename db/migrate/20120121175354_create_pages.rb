class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :modified_by
      t.text :information

      t.timestamps
    end
  end
end
