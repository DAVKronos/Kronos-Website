class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :initials
      t.string :email
      t.date :birthdate
      t.string :adress
      t.string :postalcode
      t.string :city
      t.string :sex
      t.integer :licensenumber

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
