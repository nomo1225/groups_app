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

ActiveRecord::Schema.define(version: 2021_03_25_225441) do

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

  create_table "plans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.date "start_time"
    t.datetime "plan_at"
    t.bigint "user_id"
    t.bigint "mygroup_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "attendances", "plans"
  add_foreign_key "attendances", "users"
  add_foreign_key "mygroups", "users"
  add_foreign_key "notices", "mygroups"
  add_foreign_key "notices", "users"
  add_foreign_key "plans", "mygroups"
  add_foreign_key "plans", "users"
  add_foreign_key "relationships", "mygroups"
  add_foreign_key "relationships", "users"
end
