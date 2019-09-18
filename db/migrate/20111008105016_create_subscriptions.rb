class CreateSubscriptions < ActiveRecord::Migration[4.2]
  def change
    create_table :subscriptions do |t|
      t.text :comment
      t.string :name

      t.timestamps
    end
  end
end
