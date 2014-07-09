class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.text :summary

      t.timestamps
    end
  end
end
