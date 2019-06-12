class AddPublicToPages < ActiveRecord::Migration
  def change
    add_column :pages, :public, :boolean, default:true
  end
end
