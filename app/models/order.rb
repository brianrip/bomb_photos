class Order < ActiveRecord::Base
  validates :status, presence: true
  belongs_to :user
  has_many :order_photos
  has_many :studio_orders
  has_many :photos, through: :order_photos
  has_many :studios, through: :studio_orders


  def placed_at
    created_at.strftime("%B %d, %Y")
  end

  def self.associated_photos(studio)
    #one thing we need to look at is creating a join table.
    all.select do |order|
      order.order_photos.any? do |order_photo|
        order_photo.photo.studio == studio
      end
    end
  end

  def studio_price(studio)
    price = 0
    order_photos.each do |order_photo|
      if order_photo.photo.studio == studio
        price += order_photo.photo.price
      end
    end
    price / 100.0
  end

  def format_total_price
    "$#{'%.02f' % (total_price / 100.0)}"
  end
end
