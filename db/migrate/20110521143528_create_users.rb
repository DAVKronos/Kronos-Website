class CreateUsers < ActiveRecord::Migration[4.2]
  def self.up
    create_table :users do |t|
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
      t.string :persistence_token,   :null => false
      t.string :crypted_password,    :null => false
      t.string :password_salt,       :null => false
      t.string :single_access_token, :null => false
      t.string :perishable_token,    :null => false
      t.integer :login_count,        :null => false, :default => 0
      t.integer :failed_login_count, :null => false, :default => 0
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip
      t.boolean :papieren_kronometer,          :default => false     
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
