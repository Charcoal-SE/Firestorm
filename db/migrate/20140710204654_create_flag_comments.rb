class CreateFlagComments < ActiveRecord::Migration
  def change
    create_table :flag_comments do |t|
      t.string :username
      t.text :body
      t.integer :flag_id

      t.timestamps
    end
  end
end
