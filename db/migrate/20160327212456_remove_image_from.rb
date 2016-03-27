class RemoveImageFrom < ActiveRecord::Migration
  def change
    remove_column :photos, :image
  end
end
