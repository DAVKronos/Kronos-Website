class AddWindToResults < ActiveRecord::Migration
  def change
    add_column :results, :wind, :decimal
	add_column :results, :place, :integer
	add_column :eventtypes, :show_wind, :boolean, default: false
	add_column :eventtypes, :female_formula, :string
  end
end
