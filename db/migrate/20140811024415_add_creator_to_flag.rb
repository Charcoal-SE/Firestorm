class AddCreatorToFlag < ActiveRecord::Migration
  def change
    add_column :flags, :creator, :User
  end
end
