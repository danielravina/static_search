ActiveRecord::Schema.define do
  self.verbose = false

  create_table "static_content", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
