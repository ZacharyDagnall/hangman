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

ActiveRecord::Schema.define(version: 2021_01_25_201129) do

  create_table "game_words", force: :cascade do |t|
    t.integer "game_id"
    t.integer "word_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "player_id"
    t.boolean "complete"
    t.string "word_so_far"
    t.integer "wrong_guesses"
  end

  create_table "hints", force: :cascade do |t|
    t.integer "word_id"
    t.string "the_hint"
    t.float "point_deduction"
  end

  create_table "players", force: :cascade do |t|
    t.string "username"
  end

  create_table "words", force: :cascade do |t|
    t.string "the_word"
    t.float "point_value"
  end

end