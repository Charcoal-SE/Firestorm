class AddFlagIdToFlagData < ActiveRecord::Migration
  def change
    add_column :flag_data, :flag_id, :integer
  end
end
