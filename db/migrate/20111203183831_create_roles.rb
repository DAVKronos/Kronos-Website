class CreateRoles < ActiveRecord::Migration[4.2]
  def change
    create_table "roles", :force => true do |t|
        t.string   :name,              :limit => 40
        t.string   :authorizable_type, :limit => 40
        t.integer  :authorizable_id
        t.timestamps
    end
  end
end
