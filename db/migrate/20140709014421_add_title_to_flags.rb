class AddTitleToFlags < ActiveRecord::Migration
  def change
    add_column :flags, :title, :string
  end
end
