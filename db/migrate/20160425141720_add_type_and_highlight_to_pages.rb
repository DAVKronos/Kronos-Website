class AddTypeAndHighlightToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :menu, :string
    add_column :pages, :highlight, :boolean
  end
end
