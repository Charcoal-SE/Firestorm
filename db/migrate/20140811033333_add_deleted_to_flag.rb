class AddDeletedToFlag < ActiveRecord::Migration
  def change
    add_column :flags, :deleted, :integer
  end
end
