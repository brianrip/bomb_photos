class Category < ActiveRecord::Base
  has_many :photos
  validates :name, presence: true, uniqueness: true

  scope :alpha, -> { order("name asc") }
end
