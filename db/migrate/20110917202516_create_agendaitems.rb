class CreateAgendaitems < ActiveRecord::Migration
  def change
    create_table :agendaitems do |t|
      t.string :name
      t.string :description
      t.timestamp :date
      t.string :location
      t.boolean :subscribe
      t.timestamp :subscriptiondeadline
      t.references :commission
      
      t.timestamps
    end
  end
end
