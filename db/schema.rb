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

ActiveRecord::Schema[8.1].define(version: 2025_11_21_164729) do
  create_table "previews", force: :cascade do |t|
    t.integer "count"
    t.datetime "created_at", null: false
    t.string "filename"
    t.integer "height"
    t.datetime "updated_at", null: false
    t.integer "video_id", null: false
    t.integer "width"
    t.index ["video_id"], name: "index_previews_on_video_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "tag_id"
    t.datetime "updated_at", null: false
    t.integer "video_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["video_id"], name: "index_taggings_on_video_id"
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string "checksum"
    t.datetime "created_at", null: false
    t.integer "duration"
    t.string "filename"
    t.integer "rating"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "view_count"
  end

  add_foreign_key "previews", "videos"
  add_foreign_key "taggings", "tags"
  add_foreign_key "taggings", "videos"
end
