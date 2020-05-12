class AddReserveToSubscription < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :reserve, :boolean, default: false
  end
end
