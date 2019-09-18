class AddUrlToAgendaitems < ActiveRecord::Migration[4.2]
  def change
    add_column :agendaitems, :url, :string
  end
end
