class ChangeDataTypeForPhotoPrice < ActiveRecord::Migration
  def change
    change_column :photos, :price, :float
  end
end
