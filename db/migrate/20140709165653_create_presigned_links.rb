class CreatePresignedLinks < ActiveRecord::Migration
  def change
    create_table :presigned_links do |t|
      t.integer :flag_id
      t.string :presigned_string

      t.timestamps
    end
  end
end
