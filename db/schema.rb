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

ActiveRecord::Schema.define(version: 20170608094017) do

  create_table "advertisments", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.date     "start_date"
    t.date     "term_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "band_id"
    t.integer  "user_id"
    t.text     "musicians"
    t.index ["band_id"], name: "index_advertisments_on_band_id"
    t.index ["user_id"], name: "index_advertisments_on_user_id"
  end

  create_table "bands", force: :cascade do |t|
    t.string   "name",             default: "", null: false
    t.integer  "band_manager_id"
    t.string   "description"
    t.string   "nation"
    t.string   "region"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "city"
    t.integer  "musical_genre_id", default: 0
    t.index ["band_manager_id"], name: "index_bands_on_band_manager_id"
  end

  create_table "member_associations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "joined_band_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["joined_band_id"], name: "index_member_associations_on_joined_band_id"
    t.index ["user_id"], name: "index_member_associations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birth"
    t.string   "nation"
    t.string   "region"
    t.string   "gender"
    t.string   "provider"
    t.string   "uid"
    t.string   "remember_digest"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "banned",                 default: false
    t.boolean  "admin_role",             default: false
    t.boolean  "band_manager_role",      default: false
    t.boolean  "band_member_role",       default: false
    t.boolean  "user_role",              default: true
    t.string   "city"
    t.integer  "type_of_musician_id",    default: 0
    t.integer  "musical_genre_id",       default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
