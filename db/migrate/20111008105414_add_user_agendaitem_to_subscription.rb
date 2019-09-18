class AddUserAgendaitemToSubscription < ActiveRecord::Migration[4.2]
  def change
    add_column :subscriptions, :user_id, :integer
    add_column :subscriptions, :agendaitem_id, :integer
  end
end
