class RemoveGifTagsTable < ActiveRecord::Migration
  def change
    drop_table :gif_tags
  end
end
