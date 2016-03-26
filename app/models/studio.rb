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
    Order.associated_photos(self).each do |order|
      require "pry"
      binding.pry
    end
  end
end
