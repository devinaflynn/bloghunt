class AddDescriptionToApps < ActiveRecord::Migration
  def change
    add_column :apps, :description, :string
  end
end
