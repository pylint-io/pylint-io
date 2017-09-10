class RenameLoginToServiceUid < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.rename :login, :service_uid
    end
  end
end
