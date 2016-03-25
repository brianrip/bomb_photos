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

  enum status: %w(active inactive pending denied)
end
