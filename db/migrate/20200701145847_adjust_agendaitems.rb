class AdjustAgendaitems < ActiveRecord::Migration[5.0]
  def change
    change_column_default :agendaitems, :name_en, nil
    change_column_default :agendaitems, :description_en, nil
  end
end
