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

ActiveRecord::Schema.define(version: 2021_05_27_041914) do

  create_table "accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "processed_date"
    t.string "to_whom"
    t.string "content"
    t.integer "fee"
    t.bigint "user_id"
    t.bigint "mygroup_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "treasurer"
    t.index ["mygroup_id"], name: "index_accounts_on_mygroup_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_attendances_on_plan_id"
    t.index ["user_id", "plan_id"], name: "index_attendances_on_user_id_and_plan_id", unique: true
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "cities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discussions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.bigint "mygroup_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "content"
    t.index ["mygroup_id"], name: "index_discussions_on_mygroup_id"
    t.index ["user_id"], name: "index_discussions_on_user_id"
  end

  create_table "mygroups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "category"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "group_id"
    t.integer "area"
    t.index ["group_id"], name: "index_mygroups_on_group_id", unique: true
    t.index ["user_id"], name: "index_mygroups_on_user_id"
  end

  create_table "notices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.bigint "user_id"
    t.bigint "mygroup_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mygroup_id"], name: "index_notices_on_mygroup_id"
    t.index ["user_id"], name: "index_notices_on_user_id"
  end

  create_table "omikujis", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "result"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "opinions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id"
    t.bigint "mygroup_id"
    t.bigint "discussion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discussion_id"], name: "index_opinions_on_discussion_id"
    t.index ["mygroup_id"], name: "index_opinions_on_mygroup_id"
    t.index ["user_id"], name: "index_opinions_on_user_id"
  end

  create_table "plans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.date "start_time"
    t.datetime "plan_at"
    t.bigint "user_id"
    t.bigint "mygroup_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.string "add_title"
    t.datetime "plan_until"
    t.index ["mygroup_id"], name: "index_plans_on_mygroup_id"
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "mygroup_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mygroup_id"], name: "index_relationships_on_mygroup_id"
    t.index ["user_id", "mygroup_id"], name: "index_relationships_on_user_id_and_mygroup_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_token"
    t.boolean "unnotification", default: false
  end

  create_table "weathers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "weather_main"
    t.integer "temp_min"
    t.integer "temp_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "location_id"
  end

  add_foreign_key "accounts", "mygroups"
  add_foreign_key "accounts", "users"
  add_foreign_key "attendances", "plans"
  add_foreign_key "attendances", "users"
  add_foreign_key "discussions", "mygroups"
  add_foreign_key "discussions", "users"
  add_foreign_key "mygroups", "users"
  add_foreign_key "notices", "mygroups"
  add_foreign_key "notices", "users"
  add_foreign_key "opinions", "discussions"
  add_foreign_key "opinions", "mygroups"
  add_foreign_key "opinions", "users"
  add_foreign_key "plans", "mygroups"
  add_foreign_key "plans", "users"
  add_foreign_key "relationships", "mygroups"
  add_foreign_key "relationships", "users"
end
