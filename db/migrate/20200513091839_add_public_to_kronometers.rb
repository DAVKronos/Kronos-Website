class AddPublicToKronometers < ActiveRecord::Migration[5.0]
  def change
    add_column :kronometers, :public, :boolean, default: false
  end
end
