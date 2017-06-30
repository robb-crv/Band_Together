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

ActiveRecord::Schema.define(version: 20170629152035) do

  create_table "activities", force: :cascade do |t|
    t.integer  "band_manager_id"
    t.integer  "band_id"
    t.datetime "start_date"
    t.string   "description"
    t.string   "accessibility"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "title"
    t.string   "location"
    t.float    "duration"
    t.index ["band_id"], name: "index_activities_on_band_id"
    t.index ["band_manager_id"], name: "index_activities_on_band_manager_id"
  end

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

  create_table "band_conversations", force: :cascade do |t|
    t.integer  "band_id",         null: false
    t.integer  "conversation_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
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

  create_table "following_relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "followable_type"
    t.integer  "followable_id"
    t.index ["followable_type", "followable_id"], name: "reference_followable"
    t.index ["follower_id", "followable_type", "followable_id"], name: "index_on_follower_followable_type", unique: true
    t.index ["follower_id"], name: "index_following_relationships_on_follower_id"
    t.index ["follower_id"], name: "index_following_relationships_on_follower_id_and_followed_id", unique: true
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.string  "unsubscriber_type"
    t.integer "unsubscriber_id"
    t.integer "conversation_id"
    t.index ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id"
    t.index ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type"
  end

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "band_id"
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.string   "sender_type"
    t.integer  "sender_id"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.string   "notified_object_type"
    t.integer  "notified_object_id"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
    t.index ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id"
    t.index ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type"
    t.index ["notified_object_type", "notified_object_id"], name: "mailboxer_notifications_notified_object"
    t.index ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type"
    t.index ["type"], name: "index_mailboxer_notifications_on_type"
  end

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.string   "receiver_type"
    t.integer  "receiver_id"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "is_delivered",               default: false
    t.string   "delivery_method"
    t.string   "message_id"
    t.index ["notification_id"], name: "index_mailboxer_receipts_on_notification_id"
    t.index ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type"
  end

  create_table "member_associations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "joined_band_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["joined_band_id"], name: "index_member_associations_on_joined_band_id"
    t.index ["user_id", "joined_band_id"], name: "index_on_user_joined_band", unique: true
    t.index ["user_id"], name: "index_member_associations_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "recipient_id",    null: false
    t.integer  "actor_id"
    t.datetime "read_at"
    t.string   "action"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "reviewer_id"
    t.text     "description"
    t.integer  "rating"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "reviewable_type"
    t.integer  "reviewable_id"
    t.index ["reviewable_id", "reviewable_type", "reviewer_id"], name: "index_on_reviewer_reviewed_type", unique: true
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable_type_and_reviewable_id"
    t.index ["reviewer_id"], name: "index_reviews_on_reviewer_id"
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
