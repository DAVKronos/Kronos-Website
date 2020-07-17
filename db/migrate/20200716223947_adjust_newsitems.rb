class AdjustNewsitems < ActiveRecord::Migration[5.0]
  def change
    change_column_default :newsitems, :title_en, nil
    change_column_default :newsitems, :news_en, nil
  end
end
