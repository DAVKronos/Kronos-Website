class CreateMailinglists < ActiveRecord::Migration
  def change
    create_table :mailinglists do |t|
      t.text :name
      t.text :description

      t.timestamps
    end
  end
end
