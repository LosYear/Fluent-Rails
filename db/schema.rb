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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150330171644) do

  create_table "blocks", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.string   "name",       limit: 128
    t.string   "type",       limit: 255
    t.boolean  "status",     limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blocks", ["name"], name: "index_blocks_on_name", unique: true, using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "menu_items", force: :cascade do |t|
    t.integer  "menu_id",    limit: 4
    t.integer  "parent_id",  limit: 4
    t.string   "title",      limit: 255
    t.string   "url",        limit: 255
    t.string   "type",       limit: 255
    t.integer  "order",      limit: 4
    t.boolean  "status",     limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "data_push",  limit: 1
  end

  create_table "menus", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "name",        limit: 128
    t.string   "description", limit: 255
    t.boolean  "status",      limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus", ["name"], name: "index_menus_on_name", unique: true, using: :btree

  create_table "nodes", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 16777215
    t.integer  "author",     limit: 4
    t.integer  "updater",    limit: 4
    t.string   "slug",       limit: 128
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",       limit: 255
    t.boolean  "status",     limit: 1
  end

  add_index "nodes", ["author"], name: "author", using: :btree
  add_index "nodes", ["slug"], name: "slug", unique: true, using: :btree
  add_index "nodes", ["updater"], name: "updater", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 16777215
    t.text     "preview",    limit: 16777215
    t.string   "slug",       limit: 255
    t.string   "type",       limit: 255
    t.integer  "status",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       limit: 255
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id", limit: 4
    t.integer "user_id", limit: 4
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",        limit: 128,      null: false
    t.text     "value",      limit: 16777215
    t.integer  "thing_id",   limit: 4
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "socials", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "link",              limit: 255
    t.integer  "order",             limit: 4
    t.boolean  "status",            limit: 1
    t.string   "logo_file_name",    limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_file_size",    limit: 4
    t.datetime "logo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 128, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 128
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               limit: 128
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "nodes", "users", column: "author", name: "nodes_ibfk_1"
  add_foreign_key "nodes", "users", column: "updater", name: "nodes_ibfk_2"
end
