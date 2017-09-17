class CascadeDeleteRatingsFromRepository < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :ratings, :repositories, on_delete: :cascade
  end
end
