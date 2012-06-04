class AddUserTypeToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
        t.references :user_type
    end
  end
end