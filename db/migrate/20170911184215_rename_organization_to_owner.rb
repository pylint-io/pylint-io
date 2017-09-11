class RenameOrganizationToOwner < ActiveRecord::Migration[5.1]
  def change
    change_table :repositories do |t|
      t.rename :organization, :owner
    end
  end
end
