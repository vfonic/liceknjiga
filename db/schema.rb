# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120611095942) do

  create_table "photos", :force => true do |t|
    t.boolean  "private",                 :default => false
    t.integer  "creator_id"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "photo_data_file_name"
    t.string   "photo_data_content_type"
    t.integer  "photo_data_file_size"
    t.datetime "photo_data_updated_at"
  end

  create_table "photos_likes", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "photo_id"
  end

  add_index "photos_likes", ["user_id", "photo_id"], :name => "index_photos_likes_on_user_id_and_photo_id"

  create_table "users", :force => true do |t|
    t.string   "first_name",          :limit => 25
    t.string   "last_name",           :limit => 50
    t.string   "email"
    t.string   "username",            :limit => 25
    t.string   "salt",                :limit => 40
    t.string   "hashed_password"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "users_friends", :force => true do |t|
    t.boolean  "authorized", :default => false
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

end
