class RenameOrderGifsToOrderPhotos < ActiveRecord::Migration
  def change
    rename_table :order_gifs, :order_photos
    rename_column :order_photos, :gif_id, :photo_id
    remove_column :order_photos, :quantity
    remove_column :order_photos, :subtotal
  end
end
