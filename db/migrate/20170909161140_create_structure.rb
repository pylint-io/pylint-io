class CreateStructure < ActiveRecord::Migration[5.1]
  def change
    create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string "service"
      t.string "uid"
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "repositories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.bigint "user_id"
      t.string "service"
      t.string "organization"
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["user_id"], name: "index_repositories_on_user_id"
    end

    create_table "ratings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.bigint "repository_id"
      t.string "branch"
      t.string "module"
      t.decimal "rating", precision: 10, scale: 2
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["repository_id"], name: "index_ratings_on_repository_id"
    end
  end
end
