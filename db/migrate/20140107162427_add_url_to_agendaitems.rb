class AddUrlToAgendaitems < ActiveRecord::Migration
  def change
    add_column :agendaitems, :url, :string
  end
end
