class AddGitHubAuthToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.rename :service_uid, :login
      t.rename :name, :token
    end
  end
end
