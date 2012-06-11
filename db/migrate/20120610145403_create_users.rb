class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, :limit => 25
      t.string :last_name, :limit => 50
      t.string :email
      t.string :username, :limit => 25
      t.string :salt, :limit => 40
      t.string :hashed_password
      t.timestamps
    end
    add_index("users", "username")
  end
end
