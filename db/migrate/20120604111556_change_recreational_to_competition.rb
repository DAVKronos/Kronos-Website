class ChangeRecreationalToCompetition < ActiveRecord::Migration[4.2]
  
  def change
    rename_column :user_types, :recreational, :competition
  end
  
end
