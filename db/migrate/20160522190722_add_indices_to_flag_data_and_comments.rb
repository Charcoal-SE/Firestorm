class AddIndicesToFlagDataAndComments < ActiveRecord::Migration
  def change
    add_index :flag_data, :flag_id
    add_index :flag_comments, :flag_id
  end
end
