class Studio < ActiveRecord::Base
  has_many :photos
  has_many :users
  validates :promo_image, presence: true
  validates :name, presence: true
  validates :description, presence: true

  attr_accessor :promo_image

  has_attached_file :promo_image, :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename",
    styles: {
      favicon: '16x16>',
      square: '200x200#',
      medium: '300x300>'
    }

  validates_attachment_content_type :promo_image, :content_type => /\Aimage\/.*\Z/
  before_create :set_slug

  enum status: %w(active inactive pending denied)

  def set_slug
    self.slug = name.parameterize
  end

  def studio_created_on
    created_at.strftime("%B %d, %Y")
  end

  def revenue
    revenue = 0
    Order.associated_photos(self).each do |order|
      order.order_photos.each do |order_photo|
        if order_photo.photo.studio == self
          revenue += order_photo.photo.price
        end
      end
    end
    "$#{'%.02f' % (revenue / 100.0)}"
  end

  def deactivate_all_photos
    photos.each do |photo|
      photo.update(active: false)
    end
  end

  def activate_all_photos
    photos.each do |photo|
      photo.update(active: true)
    end
  end

  def to_param
    slug
  end

  def self.find(input)
    find_by_slug(input)
  end
end
