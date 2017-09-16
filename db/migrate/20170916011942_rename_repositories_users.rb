class RenameRepositoriesUsers < ActiveRecord::Migration[5.1]
  def change
    rename_table :repositories_users, :repository_users
  end
end
