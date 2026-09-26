ActiveRecord::Schema[8.0].define(version: 1) do
  create_table "folders", force: :cascade do |t|
    t.string "name", null: false
    t.timestamps
  end

  create_table "notes", force: :cascade do |t|
    t.string "title", null: false
    t.text "body"
    t.timestamps
  end
end
