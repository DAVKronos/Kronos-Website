class CreateChangedUsers < ActiveRecord::Migration
  def change
    create_table :changed_users do |t|
          t.string :name
          t.string :initials
          t.string :email
          t.date :birthdate
          t.string :address
          t.string :postalcode
          t.string :city
          t.string :sex
          t.string :licensenumber
          t.string :login,               :null => false
          t.boolean :papieren_kronometer,          :default => false   
          t.timestamps
    end
  end
end
