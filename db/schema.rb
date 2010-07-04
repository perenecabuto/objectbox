# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100625050746) do

  create_table "boards", :force => true do |t|
    t.string   "title",      :limit => 128, :null => false
    t.string   "background", :limit => 128, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "owners_possessions", :force => true do |t|
    t.integer  "owner_id",        :null => false
    t.string   "owner_type",      :null => false
    t.integer  "possession_id",   :null => false
    t.string   "possession_type", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "postits", :force => true do |t|
    t.string   "title",            :limit => 128
    t.text     "content"
    t.integer  "x"
    t.integer  "y"
    t.string   "width",            :limit => 8
    t.string   "height",           :limit => 8
    t.string   "background_color", :limit => 16
    t.string   "color",            :limit => 16
    t.integer  "board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simpletexts", :force => true do |t|
    t.string   "title"
    t.integer  "autor_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
