class Category < ActiveRecord::Base
  has_many :photos
  validates :name, presence: true, uniqueness: true

  scope :alpha, -> { order("name asc") }

  before_create :set_slug

  def set_slug
    self.slug = name.parameterize
  end

  def to_param
    slug
  end

  def self.find(input)
    find_by_slug(input)
  end
end
