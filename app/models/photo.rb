class Photo < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :image, presence: true
  belongs_to :category
  has_many :order_photos, dependent: :destroy
  has_many :orders, through: :order_photos
  belongs_to :studio
  attr_accessor :image

  has_attached_file :image, :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename",
    styles: {
      favicon: '16x16>',
      square: '200x200#',
      medium: '300x300>'
    }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def create_tags(gif_tags)
    gif_tags.each do |tag|
      gifs_tag = Tag.find_or_create_by(name: "#{tag}")
      gifs_tag.gifs << self
    end
  end

  def self.favorite_gifs
    joins(:tags).where(tags: {name: "faves"})
  end

  def self.all_active
    Gif.all.each { |gif| gif.active }
  end
end
