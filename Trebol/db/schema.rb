# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_01_020642) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.string "file_link", default: "", null: false
    t.string "comment", default: "", null: false
    t.datetime "published_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_attachments_on_task_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "published_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "labels", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.string "title", default: "", null: false
    t.string "color", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_labels_on_board_id"
  end

  create_table "states", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.string "status", default: "", null: false
    t.integer "board_position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_states_on_board_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.bigint "informer_id", null: false
    t.bigint "assignee_id"
    t.bigint "label_id"
    t.string "title", default: "", null: false
    t.text "description", default: "", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "due_date"
    t.datetime "published_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignee_id"], name: "index_tasks_on_assignee_id"
    t.index ["informer_id"], name: "index_tasks_on_informer_id"
    t.index ["label_id"], name: "index_tasks_on_label_id"
    t.index ["state_id"], name: "index_tasks_on_state_id"
  end

  create_table "user_boards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_user_boards_on_board_id"
    t.index ["user_id"], name: "index_user_boards_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "attachments", "tasks"
  add_foreign_key "labels", "boards"
  add_foreign_key "states", "boards"
  add_foreign_key "tasks", "labels"
  add_foreign_key "tasks", "states"
  add_foreign_key "tasks", "users", column: "assignee_id"
  add_foreign_key "tasks", "users", column: "informer_id"
  add_foreign_key "user_boards", "boards"
  add_foreign_key "user_boards", "users"
end
