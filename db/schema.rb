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

ActiveRecord::Schema.define(version: 20161109000553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "player_week_stats", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "season_week_id"
    t.integer  "rush_yds",       default: 0
    t.integer  "rush_att",       default: 0
    t.integer  "rush_td",        default: 0
    t.integer  "rec_yds",        default: 0
    t.integer  "rec_made",       default: 0
    t.integer  "rec_td",         default: 0
    t.integer  "pass_att",       default: 0
    t.integer  "pass_comp",      default: 0
    t.integer  "pass_yds",       default: 0
    t.integer  "pass_td",        default: 0
    t.integer  "pass_int",       default: 0
    t.integer  "sacked",         default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["player_id"], name: "index_player_week_stats_on_player_id", using: :btree
    t.index ["season_week_id"], name: "index_player_week_stats_on_season_week_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "position"
    t.string   "current_team"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "season_weeks", force: :cascade do |t|
    t.integer  "week"
    t.integer  "season"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stored_neural_nets", force: :cascade do |t|
    t.decimal  "first_weights",  default: [],              array: true
    t.decimal  "hidden_weights", default: [],              array: true
    t.decimal  "last_weights",   default: [],              array: true
    t.decimal  "first_biases",   default: [],              array: true
    t.decimal  "hidden_biases",  default: [],              array: true
    t.decimal  "last_biases",    default: [],              array: true
    t.integer  "layer_sizes",    default: [],              array: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "week_predictions", force: :cascade do |t|
    t.decimal  "fantasy_score"
    t.integer  "player_id"
    t.integer  "season_week_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["player_id"], name: "index_week_predictions_on_player_id", using: :btree
    t.index ["season_week_id"], name: "index_week_predictions_on_season_week_id", using: :btree
  end

  add_foreign_key "player_week_stats", "players"
  add_foreign_key "player_week_stats", "season_weeks"
  add_foreign_key "week_predictions", "players"
  add_foreign_key "week_predictions", "season_weeks"
end
