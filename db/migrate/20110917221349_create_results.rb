class CreateResults < ActiveRecord::Migration[4.2]
  def change
    create_table :results do |t|
      t.string :username
      t.float :result

      t.timestamps
    end
  end
end
