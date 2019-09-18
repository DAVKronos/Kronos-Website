class CreateMailinglists < ActiveRecord::Migration[4.2]
  def change
    create_table :mailinglists do |t|
      t.text :name
      t.text :description

      t.timestamps
    end
  end
end
