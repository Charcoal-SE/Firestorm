class CreateFlagData < ActiveRecord::Migration
  def change
    create_table :flag_data do |t|
      t.string :key
      t.string :object

      t.timestamps
    end
  end
end
