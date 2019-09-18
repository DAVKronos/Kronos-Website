class CreateAliases < ActiveRecord::Migration[4.2]
  def change
    create_table :aliases do |t|
      t.text :name
      t.text :emailaddress
      t.text :description

      t.timestamps
    end
  end
end
