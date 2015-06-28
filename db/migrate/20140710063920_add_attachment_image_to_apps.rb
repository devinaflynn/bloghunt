class AddAttachmentImageToApps < ActiveRecord::Migration
  def self.up
    change_table :apps do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :apps, :image
  end
end
