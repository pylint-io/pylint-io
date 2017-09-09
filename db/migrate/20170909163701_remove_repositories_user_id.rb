class RemoveRepositoriesUserId < ActiveRecord::Migration[5.1]
  def change
    change_table :repositories do |t|
      t.remove :user_id
    end
  end
end
