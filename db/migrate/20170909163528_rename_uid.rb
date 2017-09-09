class RenameUid < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.rename :uid, :service_uid
    end
  end
end
