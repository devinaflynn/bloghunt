class AddUserIdToApps < ActiveRecord::Migration
  def change
    add_column :apps, :user_id, :string
    add_index :apps, :user_id
  end
end
