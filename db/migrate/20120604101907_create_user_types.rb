class CreateUserTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :user_types do |t|
      t.string :name
      t.boolean :donor
      t.boolean :recreational

      t.timestamps
    end
  end
end
