class AddPromoImageToStudios < ActiveRecord::Migration
  def self.up
    add_attachment :studios, :promo_image
  end

  def self.down
    remove_attachment :studios, :promo_image
  end
end
