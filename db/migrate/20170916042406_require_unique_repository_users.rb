class RequireUniqueRepositoryUsers < ActiveRecord::Migration[5.1]
  def change
    add_index :repository_users, [:repository_id, :user_id], unique: true
  end
end
