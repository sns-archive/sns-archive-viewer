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

ActiveRecord::Schema[7.2].define(version: 0) do
  create_table "channel_details", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "channel_id", null: false, comment: "チャンネルID"
    t.string "description", limit: 100, null: false, comment: "チャンネル説明"
    t.index ["channel_id"], name: "index_channel_details_on_channel_id"
    t.index ["channel_id"], name: "unique_index_channel_details_on_channel_id", unique: true
  end

  create_table "channels", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 50, null: false, comment: "チャンネル名"
    t.boolean "public_mark", null: false, comment: "公開(true)・非公開(false)の設定"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "memo_id", null: false, comment: "メモID"
    t.string "content", limit: 1024, null: false, comment: "内容"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["memo_id"], name: "index_comments_on_memo_id"
  end

  create_table "memo_tags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "memo_id", null: false, comment: "メモID"
    t.bigint "tag_id", null: false, comment: "タグID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["memo_id", "tag_id"], name: "unique_index_memo_id_and_tag_id_on_memo_tags", unique: true
    t.index ["memo_id"], name: "index_memo_tags_on_memo_id"
    t.index ["tag_id"], name: "index_memo_tags_on_tag_id"
  end

  create_table "memos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", limit: 30, null: false, comment: "メモのタイトル"
    t.text "content", null: false, comment: "メモの本文"
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
  end

  create_table "tags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "label", limit: 30, null: false, comment: "ラベル"
    t.integer "color", null: false, comment: "色"
    t.float "priority", null: false, comment: "優先度"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label"], name: "unique_index_label_on_tags", unique: true
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", limit: 30, null: false, comment: "ユーザーのEmailアドレス"
    t.string "password", limit: 30, null: false, comment: "ユーザーのpassword"
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
  end

  add_foreign_key "channel_details", "channels", name: "fk_chanel_id_on_channel_details"
  add_foreign_key "comments", "memos", name: "fk_comments_memo_id"
  add_foreign_key "memo_tags", "memos", name: "fk_memo_id_on_memo_tags"
  add_foreign_key "memo_tags", "tags", name: "fk_tag_id_on_memo_tags"
end
