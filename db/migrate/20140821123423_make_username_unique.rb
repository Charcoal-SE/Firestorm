class MakeUsernameUnique < ActiveRecord::Migration
  def up
  	add_index :users, [:username], :unique => true
  end
end
