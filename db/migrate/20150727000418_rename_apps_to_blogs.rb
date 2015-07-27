class RenameAppsToBlogs < ActiveRecord::Migration
  def change
    rename_table :apps, :blogs
  end
end
