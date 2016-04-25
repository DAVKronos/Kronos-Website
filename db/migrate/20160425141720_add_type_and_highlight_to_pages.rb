class AddTypeAndHighlightToPages < ActiveRecord::Migration
  def change
    add_column :pages, :menu, :string
    add_column :pages, :highlight, :boolean
  end
end
