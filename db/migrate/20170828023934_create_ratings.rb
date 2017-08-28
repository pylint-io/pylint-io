class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.string :service
      t.string :organization
      t.string :repository
      t.string :branch
      t.string :module
      t.decimal :rating, precision: 10, scale: 2

      t.timestamps
    end
  end
end

