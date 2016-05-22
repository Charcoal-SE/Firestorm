class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.string :title
      t.string :summary
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
