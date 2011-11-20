class AddUserAgendaitemToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :user_id, :integer
    add_column :subscriptions, :agendaitem_id, :integer
  end
end
