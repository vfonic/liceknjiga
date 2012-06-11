class CreateUsersFriends < ActiveRecord::Migration
  def change
    create_table :users_friends do |t|
      t.boolean :authorized, :default => false
      t.column :user_id, :integer
      t.column :friend_id, :integer
      t.timestamps
    end
  end
end
