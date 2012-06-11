class CreatePhotosLikes < ActiveRecord::Migration
  def up
    create_table :photos_likes, :id => false do |t|
      t.integer "photo_id"
      t.integer "user_id"
    end
    add_index :photos_likes, ["user_id", "photo_id"]
  end

  def down
    drop_table :photos_likes
  end
end
