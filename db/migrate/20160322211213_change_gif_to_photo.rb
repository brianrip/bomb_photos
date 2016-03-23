class ChangeGifToPhoto < ActiveRecord::Migration
  def change
    rename_table :gifs, :photos
    rename_column :photos, :title, :name
    rename_column :photos, :retired, :active
    rename_column :photos, :charity_id, :studio_id
  end
end
