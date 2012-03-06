class CreateRolesUsers < ActiveRecord::Migration
  def change
    create_table "roles_users", :id => false, :force => true do |t|
      t.references  :user
      t.references  :role
    end
  end
end