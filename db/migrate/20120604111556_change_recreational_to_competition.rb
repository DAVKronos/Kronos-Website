class ChangeRecreationalToCompetition < ActiveRecord::Migration
  
  def change
    rename_column :user_types, :recreational, :competition
  end
  
end
