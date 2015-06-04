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

ActiveRecord::Schema.define(version: 20150603185128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diets", force: :cascade do |t|
    t.text     "diet_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diets_recipes", id: false, force: :cascade do |t|
    t.integer "diet_id"
    t.integer "recipe_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.text   "name"
    t.float  "quantity"
    t.float  "weight"
    t.string "edaman_ingr_uri"
  end

  create_table "recipes", force: :cascade do |t|
    t.text     "title"
    t.text     "image_url"
    t.text     "source_url"
    t.text     "edamaam_uri"
    t.text     "summary"
    t.float    "total_time"
    t.float    "prep_time"
    t.float    "cooking_time"
    t.integer  "no_of_serves"
    t.float    "rating"
    t.string   "difficulty_level"
    t.text     "ingredient_lines"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.text     "email_id"
    t.string   "full_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
  end

end
