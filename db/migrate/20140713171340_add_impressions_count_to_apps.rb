class AddImpressionsCountToApps < ActiveRecord::Migration
  def change
    add_column :apps, :impressions_count, :integer
  end
end
