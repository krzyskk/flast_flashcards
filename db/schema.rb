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

ActiveRecord::Schema.define(version: 2019_11_02_214346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "lesson_id"
    t.bigint "card_id"
    t.string "answer", default: "", null: false
    t.string "status", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_answers_on_card_id"
    t.index ["lesson_id"], name: "index_answers_on_lesson_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "front", default: "", null: false
    t.string "back", default: "", null: false
    t.boolean "active", default: true, null: false
    t.boolean "memorized", default: false, null: false
    t.integer "correct_answers", default: 0, null: false
    t.integer "wrong_answers", default: 0, null: false
    t.integer "empty_answers", default: 0, null: false
    t.integer "word_class", default: 0, null: false
    t.datetime "last_showed_at"
    t.datetime "marked_as_memorized"
    t.datetime "last_correct_answer"
    t.datetime "last_wrong_answer"
    t.bigint "deck_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deck_id"], name: "index_cards_on_deck_id"
    t.index ["front", "back", "word_class"], name: "index_cards_on_front_and_back_and_word_class", unique: true
  end

  create_table "days", force: :cascade do |t|
    t.datetime "date"
    t.text "note"
    t.string "resolution"
    t.string "main_task"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_days_on_user_id"
  end

  create_table "decks", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_decks_on_user_id"
  end

  create_table "habits", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "active"
    t.integer "repeat_type"
    t.string "repeat_pattern"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_habits_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.bigint "deck_id"
    t.integer "memorized", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "correct", default: 0
    t.integer "wrong", default: 0
    t.integer "empty", default: 0
    t.index ["deck_id"], name: "index_lessons_on_deck_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "short_answer"
    t.string "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "familiarity", default: 0, null: false
    t.integer "completation", default: 0, null: false
  end

  create_table "results", force: :cascade do |t|
    t.integer "day_id"
    t.integer "habit_id"
    t.integer "result"
    t.boolean "success", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "short_questions", force: :cascade do |t|
    t.string "question"
    t.string "answer"
    t.bigint "note_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id"], name: "index_short_questions_on_note_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "color"
    t.integer "priority"
    t.boolean "done"
    t.bigint "day_id"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_tasks_on_day_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "cards"
  add_foreign_key "answers", "lessons"
  add_foreign_key "cards", "decks"
  add_foreign_key "days", "users"
  add_foreign_key "decks", "users"
  add_foreign_key "habits", "users"
  add_foreign_key "lessons", "decks"
  add_foreign_key "short_questions", "notes"
  add_foreign_key "tasks", "days"
end
