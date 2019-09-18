class AddPublicToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :public, :boolean, default:true
  end
end
